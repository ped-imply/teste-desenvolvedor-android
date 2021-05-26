import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:imply/model/model_transacao.dart';
import 'package:imply/repository/repository.dart';
import 'package:imply/view/widgets/view_card.dart';
import 'package:imply/model/model_produto.dart';
import 'package:flutter/material.dart';

class ControllerProdutos extends GetxController {
  /// Ao iniciar o controlador atual, executa a função declarada em seu escopo [onInit]
  void onInit() {
    obterProdutos();
    super.onInit();
  }

  /// Chama a classe responsável pela manipulação dos dados no banco de dados [_repository]
  Repository _repository = Repository();

  ///Lista dos cards dos produtos com observadores de estado [cardsComidas] [cardsBebidas]
  RxList<ViewCustomCard> cardsComidas = <ViewCustomCard>[].obs;
  RxList<ViewCustomCard> cardsBebidas = <ViewCustomCard>[].obs;

  ///Lista das linhas da tabela da tela do extrato [produtosCheckout]
  RxList<TableRow> produtosCheckout = <TableRow>[].obs;

  /// Variável com observador de estado. Variável responsável pela quantidade total de itens [quantidade]
  var quantidade = 0.obs;

  /// Variável com observador de estado. Variável responsável pelo valor total de itens [total]
  var total = 0.0.obs;

  /// Função para obtenção dos dados a partir da API dada [obterProdutos]
  /// Os produtos são inseridos em suas respectivas listas [cardsComidas] [cardsBebidas] por categoria
  /// Se no processo de obtenção de dados ocorrer um erro, então o erro é tratado
  void obterProdutos() {
    try {
      Dio().get('https://ah.we.imply.com/cashless/produtos').then((valor) {
        if (valor.statusCode == 200) {
          for (int i = 0; i < valor.data['result']['rows'].length; i++) {
            if (valor.data['result']['rows'][i]['dsc_produto_cat'] !=
                "Bebidas") {
              cardsComidas.add(ViewCustomCard(
                  Produto.fromJson(valor.data['result']['rows'][i])));
            } else {
              cardsBebidas.add(ViewCustomCard(
                  Produto.fromJson(valor.data['result']['rows'][i])));
            }
          }
        }
      });
    } catch (error) {
      Get.snackbar('Erro',
          'Sentimos muito. Ocorreu um erro ao carregar a lista de produtos.');
    }
  }

  ///Função responsável por adicionar itens ao carrinho
  /// Se caso não for possível atualizar o produto já existente com a função [updateCarrinho]
  /// Insere o produto no carrinho chamando a função [insertCarrinho]
  /// Assim como também, após o processamento, a quantidade unitária [quantidadeProduto], a quantidade total [quantidadeTotal] e o valor total [valorTotal]
  /// são retornados
  void inserirProdutoCarrinho(Produto produto) async {
    int resposta = await _repository.updateCarrinho(row: produto.toJson());

    if (resposta == 0) {
      await _repository.insertCarrinho(row: produto.toJson());
    }

    List<Map<String, dynamic>> quantidadeTotal =
        await _repository.queryAllQuantidadeCarrinho();
    quantidade.value = quantidadeTotal[0]['total'];

    List<Map<String, dynamic>> valorTotal =
        await _repository.queryValorTotalCarrinho();
    total.value = double.parse(valorTotal[0]['total'].toString());

    List<Map<String, dynamic>> quantidadeProduto =
        await _repository.queryQuantidadeCarrinho(produto.toJson());

    produto.quantidade = quantidadeProduto[0]['quantidade'];
  }

  /// Função responsável por obter os produtos do carrinho
  /// Obtém os dados do banco de dados [queryAllCarrinho]
  /// e acrescenta os produtos a tela extrato [produtosCheckout]
  void obterProdutosCarrinho() async {
    produtosCheckout.clear();

    List<Map<String, dynamic>> produtosCarrinho =
        await _repository.queryAllCarrinho();

    for (int i = 0; i < produtosCarrinho.length; i++) {
      produtosCheckout.add(TableRow(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            produtosCarrinho[i]['descricao_produto'],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            produtosCarrinho[i]['quantidade'].toString(),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "R\$${produtosCarrinho[i]['valor_unitario'].toStringAsFixed(2).replaceAll('.', ',')}",
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "R\$${produtosCarrinho[i]['valor_total'].toStringAsFixed(2).replaceAll('.', ',')}",
          ),
        )
      ]));
    }
  }

  /// Função responsável por limpar o carrinho
  /// Limpa o carrinho tanto no banco de dados [limparCarrinho]
  /// como também nas variáveis persistidas [quantidade] [total] e nos models [cardsComidas] [cardsBebidas]
  void limparCarrinho() async {
    await _repository.limparCarrinho();
    quantidade.value = 0;
    total.value = 0.0;
    produtosCheckout.clear();
    cardsComidas.forEach((element) => element.produto.quantidade = 0);
    cardsBebidas.forEach((element) => element.produto.quantidade = 0);
  }

  /// Função responsável por alocar os extratos no banco de dados
  /// Obtém os dados do carrinho [carrinho] pela função [queryAllCarrinho]
  /// Verifica se o carrinho não está vazio
  /// E então persiste os dados no banco de dados
  /// Logo, limpa o carrinho, retorna a tela inicial e mostra uma mensagem de succeso ao usuário
  void comprar() async {
    List<Map<String, dynamic>> carrinho = await _repository.queryAllCarrinho();

    if (carrinho == [] || carrinho.length == 0 || carrinho.isEmpty) {
      Get.snackbar('Divergênia', 'Seu carrinho está vazio',
          backgroundColor: Colors.yellowAccent[700],
          colorText: Color(0xff005c92));
    } else {
      for (int i = 0; i < carrinho.length; i++) {
        await _repository.insertCompra(
            row: Transacao(
                    descricaoProduto: carrinho[i]['descricao_produto'],
                    quantidade: carrinho[i]['quantidade'],
                    valorUnitarioProduto:
                        double.parse(carrinho[i]['valor_unitario'].toString()),
                    valorTotalProduto:
                        double.parse(carrinho[i]['valor_total'].toString()))
                .toJson());
      }
      limparCarrinho();
      Get.back();
      Get.snackbar('Sucesso', 'Compra efetuada com sucesso',
          backgroundColor: Color(0xff005c92), colorText: Colors.white);
    }
  }
}
