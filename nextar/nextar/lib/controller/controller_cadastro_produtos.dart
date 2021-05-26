import 'package:nextar/database/database.dart';
import 'package:nextar/model/model_produto.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:nextar/view/widgets/view_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller_cadastro_usuarios.dart';

class ControllerCadastroProdutos extends GetxController {
  void onInit() {
    super.onInit();
    listarProdutos();
  }

  // Chama a instância do banco de dados
  final DatabaseHelper _database = DatabaseHelper.instance;

  // Lista de cards para popular o layout
  List<ViewCustomCard> produtosCard = <ViewCustomCard>[].obs;

  // Array de bytes (stream) para salvar e carregar a imagem do banco de dados
  var _image = Uint8List(0).obs;
  get image => this._image.value;

  // Método responsável por salvar produtos corretamente no banco de dados
  void cadastrarProduto(String descricaoProduto, String preco,
      String quantidadeEstoque, String codigo) async {
    // Realiza uma busca no banco de dados pelo código do produto
    List<Map<String, dynamic>> _verificarProduto =
        await _database.selectProdutos(
            columns: ['codigo'], where: 'codigo = ?', whereArgs: [codigo]);

    // Verifica se o produto já existe
    if (_verificarProduto.isNotEmpty) {
      Get.snackbar('Divergência', 'Produto já cadastrado');
    }

    // Se este não existir, verifica se os campos obrigatórios foram preenchidos corretamente
    else {
      // Se os campos forem preenchidos corretamente, prossegue com a criação do produto
      if (descricaoProduto.trim().isNotEmpty && codigo.trim().isNotEmpty) {
        SharedPreferences _prefs = await SharedPreferences.getInstance();

        // Instancia um model do produto com os parâmetros dados na função
        final Produto _produto = Produto(
            idUser: _prefs.getInt('idUsuario'),
            descricaoProduto: descricaoProduto,
            preco: preco.isEmpty
                ? null
                : double.parse(
                    preco.replaceAll(',', '.').replaceAll('R\$', '')),
            quantidadeEstoque:
                quantidadeEstoque.isEmpty ? null : int.parse(quantidadeEstoque),
            codigo: codigo,
            dataCriacao: DateTime.now().toString(),
            imagem: this._image.value);

        // Salva o produto no banco de dados já convertendo o model para um map
        int _resposta = await _database.insertProduto(row: _produto.toMap());

        // Se for retornado um id de inserção, notifica com uma mensagem de sucesso
        if (_resposta > 0) {
          Get.back();
          Get.snackbar('Sucesso', 'Produto cadastrado com sucesso!');
          _image.value = Uint8List(0);
          listarProdutos();
        }

        // Caso contrário, notifica um erro
        else {
          Get.snackbar('Erro',
              'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
        }
      }

      // Caso contrário, solicita que os campos sejam preenchidos corretamente
      else {
        Get.snackbar(
            'Divergência', 'Preencha os campos obrigatórios corretamente');
      }
    }
  }

  // Método responsável por obter as imagens dos produtos
  void obterImagemProduto() async {
    // Instancia a biblioteca resposável por manipular as imagens
    final _picker = ImagePicker();

    // Obtém a imagem a partir da galeria de imagem e salva na variável
    final _pickedFile = await _picker.getImage(source: ImageSource.gallery);

    // Se o dado obtido for diferente de nulo
    if (_pickedFile != null) {
      _image.value = await _pickedFile
          .readAsBytes(); // Guarda o stream de bytes no array de bytes
    }
  }

  // Método responsável pela obtenção e listagem dos produtos corretamente
  Future<List<ViewCustomCard>> listarProdutos() async {
    // Biblioteca responsável pela persistência de dados local, como um cookie
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    // Limpeza do array de cards para evitar duplicidade de produtos
    produtosCard.clear();

    // Obtenção do id do usuario persistidos no caso de sucesso do login
    int idUsuario = _prefs.getInt('idUsuario');

    // Obtenção dos produtos alocados no banco de dados
    List<Map<String, dynamic>> _resposta =
        await _database.queryAllRowsProdutos(idUsuario: idUsuario);

    // Adicionando os dados dos produtos obtidos para cards e inserindo estes no
    // array e em seguida seu retorno
    for (var produto in _resposta) {
      var p = Produto.fromJson(produto);
      print(p.preco);
      produtosCard.add(ViewCustomCard(
          produto: Produto(
              idProduto: p.idProduto,
              idUser: _prefs.getInt('idUsuario'),
              descricaoProduto: p.descricaoProduto,
              preco: p.preco,
              quantidadeEstoque: p.quantidadeEstoque,
              codigo: p.codigo,
              dataCriacao: p.dataCriacao,
              imagem: p.imagem)));
    }
    return produtosCard;
  }

  // Método responsável por editar os produtos corretamente
  void editarProduto(int idProduto, String descricaoProduto, String preco,
      String quantidadeEstoque, String codigo) async {
    // Envio de map com apenas as linhas a serem editadas para o banco de dados
    // Em seguida, a resposta é retornada com o respectivo id da linha editada
    int _resposta = await _database.updateProdutos(row: {
      'id_produto': idProduto,
      'descricaoProduto': descricaoProduto,
      'preco': preco.isEmpty
          ? 0.00
          : double.parse(preco.replaceAll(',', '.').replaceAll('R\$', '')),
      'quantidade':
          quantidadeEstoque.isEmpty ? 0 : int.parse(quantidadeEstoque),
      'imagem_produto': _image.value
    });

    // Se for retornado um id de edição da linha, então uma notificação de sucesso é mostrada
    if (_resposta > 0) {
      Get.back();
      Get.snackbar('Sucesso', 'Produto editado com sucesso!');
      _image.value = Uint8List(0);
      listarProdutos();
    }

    // Caso contrário, notifica um erro
    else {
      Get.snackbar('Erro',
          'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
    }
  }

  // Método responsável por deletar o produto corretamente
  void deletarProduto(String codigoProduto) async {
    // Envio de código de barras com base nos parâmetros do método para
    // localização e deleção do produto
    int _resposta = await _database.deleteProduto(codigoProduto: codigoProduto);

    // Se for retornado um id de deleção da linha, então uma notificação de sucesso é mostrada
    if (_resposta > 0) {
      Get.back();
      listarProdutos();
      Get.snackbar('Sucesso', 'Produto deletado com sucesso!');
    }

    // Caso contrário, notifica um erro
    else {
      Get.snackbar('Erro',
          'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
    }
  }

  // Abaixo, temos os métodos responsáveis por listar os produtos com filtros corretamente

  Future<List<ViewCustomCard>> filtrarProdutoPorData() async {
    // Biblioteca responsável pela persistência de dados local, como um cookie
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    // Limpeza do array de cards para evitar duplicidade de produtos
    produtosCard.clear();

    // Obtenção do id do usuario persistidos no caso de sucesso do login
    int idUsuario = _prefs.getInt('idUsuario');

    // Obtenção dos produtos alocados no banco de dados por data de criação
    List<Map<String, dynamic>> _resposta =
        await _database.queryAllRowsProdutosData(idUsuario: idUsuario);

    // Adicionando os dados dos produtos obtidos para cards e inserindo estes no
    // array e em seguida, retorna para a tela principal e retorna o array de cards
    for (var produto in _resposta) {
      var p = Produto.fromJson(produto);
      produtosCard.add(ViewCustomCard(
          produto: Produto(
              idProduto: p.idProduto,
              idUser: _prefs.getInt('idUsuario'),
              descricaoProduto: p.descricaoProduto,
              preco: p.preco,
              quantidadeEstoque: p.quantidadeEstoque,
              codigo: p.codigo,
              dataCriacao: p.dataCriacao,
              imagem: p.imagem)));
    }
    Get.back();
    return produtosCard;
  }

  Future<List<ViewCustomCard>> filtrarProdutoPorPreco() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    produtosCard.clear();

    int idUsuario = _prefs.getInt('idUsuario');

    List<Map<String, dynamic>> _resposta =
        await _database.queryAllRowsProdutosPreco(idUsuario: idUsuario);

    for (var produto in _resposta) {
      var p = Produto.fromJson(produto);
      produtosCard.add(ViewCustomCard(
          produto: Produto(
              idProduto: p.idProduto,
              idUser: _prefs.getInt('idUsuario'),
              descricaoProduto: p.descricaoProduto,
              preco: p.preco,
              quantidadeEstoque: p.quantidadeEstoque,
              codigo: p.codigo,
              dataCriacao: p.dataCriacao,
              imagem: p.imagem)));
    }
    Get.back();
    return produtosCard;
  }

  Future<List<ViewCustomCard>> filtrarProdutoPorOrdemAlfabetica() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    produtosCard.clear();

    int idUsuario = _prefs.getInt('idUsuario');

    List<Map<String, dynamic>> _resposta = await _database
        .queryAllRowsProdutosOrdemAlfabetica(idUsuario: idUsuario);

    for (var produto in _resposta) {
      var p = Produto.fromJson(produto);
      produtosCard.add(ViewCustomCard(
          produto: Produto(
              idProduto: p.idProduto,
              idUser: _prefs.getInt('idUsuario'),
              descricaoProduto: p.descricaoProduto,
              preco: p.preco,
              quantidadeEstoque: p.quantidadeEstoque,
              codigo: p.codigo,
              dataCriacao: p.dataCriacao,
              imagem: p.imagem)));
    }
    Get.back();
    return produtosCard;
  }
}
