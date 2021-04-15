import 'package:admin_newpedido/controller/imagem_categoria_controller.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroCategorias extends StatelessWidget {
  final CategoriaController controller = Get.put(CategoriaController());

  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(40),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child:
                              Obx(() => controller.selectedImagePath.value == ''
                                  ? Center(child: Text("Selecione a imagem"))
                                  : Container(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: Image.network(
                                          controller.selectedImagePath.value),
                                    ))),
                      Container(
                          width: MediaQuery.of(context).size.width / 4.8,
                          child: TextFormField(
                            decoration: Decor(
                                labelText:
                                    "Descrição da categoria; ex: Infantil",
                                isDense: true),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 10,
                                margin: EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.getImage();
                                  },
                                  child: Text("Inserir imagem"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731)),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Salvar"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff38377b))),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
