import 'package:badges/badges.dart';
import 'package:imply/controller/controller_produtos.dart';
import 'package:imply/model/model_produto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewCustomCard extends StatelessWidget {
  ViewCustomCard(Produto produto, {int quantidade})
      : this._produto = produto,
        this._quantidade = quantidade;

  final _controller = Get.put(ControllerProdutos());
  final Produto _produto;
  final int _quantidade;

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150,
        height: 230,
        child: Badge(
          toAnimate: true,
          showBadge:
              this._quantidade == 0 || this._quantidade == null ? false : true,
          shape: BadgeShape.circle,
          badgeColor: Colors.red,
          badgeContent: Text(
            this._quantidade.toString(),
            style: TextStyle(color: Colors.white),
          ),
          child: Container(
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      _produto.descricaoProduto,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Image.memory(
                      _produto.imagem,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Text(
                      "R\$${_produto.valor.toStringAsFixed(2).replaceAll('.', ',')}",
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
        _controller.inserirProdutoCarrinho(_produto);
      },
    );
  }
}
