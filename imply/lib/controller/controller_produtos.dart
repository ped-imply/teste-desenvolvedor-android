import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:imply/repository/repository.dart';
import 'package:imply/view/widgets/view_card.dart';
import 'package:imply/model/model_produto.dart';
import 'package:flutter/material.dart';

class ControllerProdutos extends GetxController {
  void onInit() {
    obterProdutos();
    super.onInit();
  }

  Repository _repository = Repository();

  RxList<Widget> cardsComidas = <Widget>[].obs;
  RxList<Widget> cardsBebidas = <Widget>[].obs;

  var quantidade = 0.obs;

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
        } else {
          cardsComidas.add(Center(
            child: Text("Ocorreu um erro ao carregar os produtos. :("),
          ));
          cardsBebidas.add(Center(
            child: Text("Ocorreu um erro ao carregar os produtos. :("),
          ));
        }
      });
    } catch (error) {
      Get.snackbar('Erro',
          'Sentimos muito. Ocorreu um erro ao carregar a lista de produtos.');
    }
  }

  void inserirProdutoCarrinho(Produto produto) async {
    int resposta = await _repository.updateCarrinho(row: produto.toJson());

    if (resposta == 0) {
      _repository.insertCarrinho(row: produto.toJson());
    }

    print(obterQuantidadeItensCarrinho());
  }

  void limparCarrinho() {
    _repository.limparCarrinho();
  }

  obterQuantidadeItensCarrinho() {
    _repository.queryQuantidadeCarrinho();
  }

  obterValorTotalCarrinho() {
    _repository.queryValorTotalCarrinho();
  }
}
