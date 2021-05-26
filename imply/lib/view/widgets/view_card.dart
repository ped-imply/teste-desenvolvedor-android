import 'package:badges/badges.dart';
import 'package:imply/controller/controller_produtos.dart';
import 'package:imply/model/model_produto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewCustomCard extends StatelessWidget {
  ViewCustomCard(Produto produto) : this.produto = produto;

  final _controller = Get.put(ControllerProdutos());
  final Produto produto;

  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return GestureDetector(
      child: Container(
        width: _width / 3,
        height: _height / 3.5,
        child: Badge(
          toAnimate: true,
          showBadge: true,
          shape: BadgeShape.circle,
          position: BadgePosition.topEnd(end: 0, top: -2),
          badgeColor: Colors.red,
          badgeContent: Obx(() => _controller.quantidade.value == 0 ||
                  _controller.quantidade.value == null
              ? Text(
                  "0",
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  produto.quantidade.toString(),
                  style: TextStyle(color: Colors.white),
                )),
          child: Container(
            width: _width / 3,
            height: _height / 3.5,
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      produto.descricaoProduto,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Image.memory(
                      produto.imagem,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Text(
                      "R\$${produto.valor.toStringAsFixed(2).replaceAll('.', ',')}",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _controller.inserirProdutoCarrinho(produto);
      },
    );
  }
}
