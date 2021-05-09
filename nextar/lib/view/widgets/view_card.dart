import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Nextar/model/model_produto.dart';

class ViewCustomCard extends StatelessWidget {
  ViewCustomCard({@required Produto produto}) : this._produto = produto;

  final Produto _produto;

  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.height;
    final _height = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Container(
            width: _width / 4,
            child: Card(
              elevation: 5,
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      height: _height / 4,
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: _width / 2.3,
                            alignment: Alignment.center,
                            child: Text(
                              _produto.descricaoProduto,
                              style: GoogleFonts.lato(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            width: _width / 2.3,
                            child: Divider(
                              color: Colors.redAccent[700],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: _width / 4,
                            alignment: Alignment.center,
                            child: Text(
                              "Quantidade: ${_produto.quantidadeEstoque}",
                              style: GoogleFonts.lato(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Código: ${_produto.codigo}",
                              style: GoogleFonts.lato(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: _width / 2.3,
                            alignment: Alignment.center,
                            child: Text(
                              _produto.preco.toString(),
                              style: GoogleFonts.lato(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {},
              ),
            ),
          );
        } else {
          return Container(
            width: _width / 4,
            child: Card(
              elevation: 5,
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.purple),
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      height: _height / 3,
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: _width / 2.3,
                            alignment: Alignment.center,
                            child: Text(
                              _produto.descricaoProduto,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            width: _width / 2.3,
                            child: Divider(
                              color: Colors.redAccent[700],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: _width / 4,
                            alignment: Alignment.center,
                            child: Text(
                              "Quantidade: ${_produto.quantidadeEstoque}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Código: ${_produto.codigo}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: _width / 2.3,
                            alignment: Alignment.center,
                            child: Text(
                              _produto.preco.toString(),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {},
              ),
            ),
          );
        }
      },
    );
  }
}
