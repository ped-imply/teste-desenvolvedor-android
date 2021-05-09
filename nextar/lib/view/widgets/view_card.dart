import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Nextar/model/model_produto.dart';
import 'package:get/get.dart';

import '../../controller/controller_cadastro_produtos.dart';

class ViewCustomCard extends StatelessWidget {
  ViewCustomCard({@required Produto produto}) : this._produto = produto;

  final Produto _produto;
  final _controllerCadastroProdutos = Get.find<ControllerCadastroProdutos>();

  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.height;
    final _height = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Container(
            width: _width / 4,
            child: GestureDetector(
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: _produto.imagem.lengthInBytes == 0
                            ? Container(
                                child: Center(
                                  child: Text("Sem imagem",
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                ),
                              )
                            : Image.memory(_produto.imagem),
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
                            ),
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => Get.dialog(Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: Center(
                                        child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 20,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                              "Deseja excluir o produto ${_produto.descricaoProduto}?",
                                              style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: ElevatedButton(
                                                  onPressed: () =>
                                                      _controllerCadastroProdutos
                                                          .deletarProduto(
                                                              _produto.codigo),
                                                  child: Text("Sim"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.redAccent),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: ElevatedButton(
                                                    onPressed: () => Get.back(),
                                                    child: Text("Não"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                  )),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => Get.toNamed(
                                      '/edicaoProdutos',
                                      arguments: [
                                        _produto.idUsuario,
                                        _produto.idProduto,
                                        _produto.descricaoProduto,
                                        _produto.preco,
                                        _produto.quantidadeEstoque,
                                        _produto.codigo,
                                        _produto.imagem
                                      ]),
                                ),
                              ],
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Get.toNamed(
                      '/edicaoProdutos',
                      arguments: [
                        _produto.idUsuario,
                        _produto.idProduto,
                        _produto.descricaoProduto,
                        _produto.preco,
                        _produto.quantidadeEstoque,
                        _produto.codigo,
                        _produto.imagem
                      ],
                    )),
          );
        } else {
          return Container(
            width: _width / 4,
            child: GestureDetector(
              child: Card(
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: _produto.imagem.lengthInBytes == 0
                          ? Container(
                              child: Center(
                                child: Text(
                                  "Sem imagem",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ),
                            )
                          : Image.memory(_produto.imagem),
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
                          ),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => Get.dialog(Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                      child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 20, left: 10, right: 10),
                                          child: Text(
                                            "Deseja excluir o produto ${_produto.descricaoProduto}?",
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    _controllerCadastroProdutos
                                                        .deletarProduto(
                                                            _produto.codigo),
                                                child: Text("Sim"),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.redAccent),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: ElevatedButton(
                                                  onPressed: () => Get.back(),
                                                  child: Text("Não"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.green)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                )),
                              ),
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => Get.toNamed(
                                          '/edicaoProdutos',
                                          arguments: [
                                            _produto.idUsuario,
                                            _produto.idProduto,
                                            _produto.descricaoProduto,
                                            _produto.preco,
                                            _produto.quantidadeEstoque,
                                            _produto.codigo,
                                            _produto.imagem
                                          ])),
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => Get.toNamed(
                '/edicaoProdutos',
                arguments: [
                  _produto.idUsuario,
                  _produto.idProduto,
                  _produto.descricaoProduto,
                  _produto.preco,
                  _produto.quantidadeEstoque,
                  _produto.codigo,
                  _produto.imagem
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
