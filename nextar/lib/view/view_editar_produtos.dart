import 'package:Nextar/controller/controller_cadastro_produtos.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewEdicaoProdutos extends StatelessWidget {
  final TextEditingController _descricaoProduto =
      TextEditingController(text: Get.arguments[2]);
  final MoneyMaskedTextController _preco = MoneyMaskedTextController(
      leftSymbol: 'R\$',
      decimalSeparator: ',',
      thousandSeparator: '',
      initialValue: Get.arguments[3]);
  final TextEditingController _quantidadeEstoque =
      TextEditingController(text: Get.arguments[4].toString());
  final TextEditingController _codigo =
      TextEditingController(text: Get.arguments[5]);

  final _controllerCadastroProdutos = Get.find<ControllerCadastroProdutos>();

  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 450 && constraints.maxHeight >= 360) {
        return Scaffold(
            body: Container(
          margin: EdgeInsets.all(40),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                  width: _width,
                  height: _height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              width: _width / 4,
                              child: TextFormField(
                                  controller: _descricaoProduto,
                                  cursorColor: Colors.redAccent,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintText: 'Descrição do produto',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)))),
                            ),
                            Container(
                                width: _width / 10,
                                child: TextFormField(
                                    controller: _preco,
                                    cursorColor: Colors.redAccent,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        hintText: 'Preço',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red))))),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                width: _width / 10,
                                child: TextFormField(
                                    controller: _quantidadeEstoque,
                                    cursorColor: Colors.redAccent,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        hintText: 'Qtd.',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red))))),
                            Container(
                                width: _width / 10,
                                child: TextFormField(
                                    controller: _codigo,
                                    cursorColor: Colors.redAccent,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        hintText: 'Codigo',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red)))))
                          ],
                        ),
                        GestureDetector(
                          onTap: () =>
                              _controllerCadastroProdutos.obterImagemProduto(),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: _width / 4,
                            height: _height / 4,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.red),
                                    left: BorderSide(color: Colors.red),
                                    right: BorderSide(color: Colors.red),
                                    top: BorderSide(color: Colors.red))),
                            child: Obx(() => _controllerCadastroProdutos
                                        .image.lengthInBytes ==
                                    0
                                ? Center(
                                    child: Container(
                                      width: _width,
                                      child: Text(
                                        "Selecione uma imagem",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                        width: _width,
                                        child: Image.memory(
                                            _controllerCadastroProdutos.image)),
                                  )),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                              onPressed: _descricaoProduto.text
                                          .trim()
                                          .isNotEmpty &&
                                      _codigo.text.trim().isNotEmpty
                                  ? () =>
                                      _controllerCadastroProdutos.editarProduto(
                                          Get.arguments[1],
                                          _descricaoProduto.text,
                                          _preco.text,
                                          _quantidadeEstoque.text,
                                          _codigo.text)
                                  : null,
                              child: Text("Salvar"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
      } else if (constraints.maxWidth <= 450 && constraints.maxHeight <= 360) {
        return Scaffold(
            body: Container(
          width: _width,
          height: _height,
          margin: EdgeInsets.all(20),
          child: Container(
              height: _height,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: _width / 2,
                          child: TextFormField(
                              controller: _descricaoProduto,
                              cursorColor: Colors.redAccent,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: 'Descrição do produto',
                                  hintStyle: TextStyle(fontSize: 13),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)))),
                        ),
                        Container(
                            width: _width / 5,
                            child: TextFormField(
                                controller: _preco,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Preço',
                                    hintStyle: TextStyle(fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))))),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: _width / 5,
                            child: TextFormField(
                                controller: _quantidadeEstoque,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Qtd.',
                                    hintStyle: TextStyle(fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))))),
                        Container(
                            width: _width / 5,
                            child: TextFormField(
                                controller: _codigo,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Codigo',
                                    hintStyle: TextStyle(fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)))))
                      ],
                    ),
                    GestureDetector(
                      onTap: () =>
                          _controllerCadastroProdutos.obterImagemProduto(),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: _width / 2,
                        height: _height / 4,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.red),
                                left: BorderSide(color: Colors.red),
                                right: BorderSide(color: Colors.red),
                                top: BorderSide(color: Colors.red))),
                        child: Obx(() =>
                            _controllerCadastroProdutos.image.lengthInBytes == 0
                                ? Center(
                                    child: Container(
                                      width: _width,
                                      child: Text(
                                        "Selecione uma imagem",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                        width: _width,
                                        child: Image.memory(
                                            _controllerCadastroProdutos.image)),
                                  )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _descricaoProduto.text.trim().isNotEmpty &&
                                  _codigo.text.trim().isNotEmpty
                              ? () => _controllerCadastroProdutos.editarProduto(
                                  Get.arguments[1],
                                  _descricaoProduto.text,
                                  _preco.text,
                                  _quantidadeEstoque.text,
                                  _codigo.text)
                              : null,
                          child: Text("Salvar"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
        ));
      } else {
        return Scaffold(
            body: Container(
          height: _height,
          margin: EdgeInsets.all(20),
          child: Container(
              height: _height,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: _width / 2,
                          child: TextFormField(
                              controller: _descricaoProduto,
                              cursorColor: Colors.redAccent,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: 'Descrição do produto',
                                  hintStyle: TextStyle(fontSize: 13),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)))),
                        ),
                        Container(
                            width: _width / 5,
                            child: TextFormField(
                                controller: _preco,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Preço',
                                    hintStyle: TextStyle(fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))))),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: _width / 5,
                            child: TextFormField(
                                controller: _quantidadeEstoque,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Qtd.',
                                    hintStyle: TextStyle(fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))))),
                        Container(
                            width: _width / 5,
                            child: TextFormField(
                                controller: _codigo,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Codigo',
                                    hintStyle: TextStyle(fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)))))
                      ],
                    ),
                    GestureDetector(
                      onTap: () =>
                          _controllerCadastroProdutos.obterImagemProduto(),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: _width / 2,
                        height: _height / 4,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.red),
                                left: BorderSide(color: Colors.red),
                                right: BorderSide(color: Colors.red),
                                top: BorderSide(color: Colors.red))),
                        child: Obx(() =>
                            _controllerCadastroProdutos.image.lengthInBytes == 0
                                ? Center(
                                    child: Container(
                                      width: _width,
                                      child: Text(
                                        "Selecione uma imagem",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                        width: _width,
                                        child: Image.memory(
                                            _controllerCadastroProdutos.image)),
                                  )),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          onPressed: _descricaoProduto.text.trim().isNotEmpty &&
                                  _codigo.text.trim().isNotEmpty
                              ? () => _controllerCadastroProdutos.editarProduto(
                                  Get.arguments[1],
                                  _descricaoProduto.text,
                                  _preco.text,
                                  _quantidadeEstoque.text,
                                  _codigo.text)
                              : null,
                          child: Text("Salvar"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
        ));
      }
    });
  }
}
