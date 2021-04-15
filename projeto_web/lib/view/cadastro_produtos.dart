import 'package:admin_newpedido/controller/login_controller.dart';
import 'package:admin_newpedido/controller/produtos_controller.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:html';

class CadastroProdutos extends StatelessWidget {
  final ProdutosController controller = Get.put(ProdutosController());
  final auth = Get.find<LoginController>();

  Widget build(BuildContext context) {
    auth.checkToken();
    controller.listarCategorias();

    var _imagem1;
    var _imagem2;
    var _imagem3;

    List<Widget> _images = [_imagem1, _imagem2, _imagem3];

    TextEditingController _codigoBarras = TextEditingController();
    TextEditingController _descricaoProduto = TextEditingController();
    MoneyMaskedTextController _avista = MoneyMaskedTextController(
        decimalSeparator: ",", thousandSeparator: ".");
    TextEditingController _aprazo = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(40),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                    child: Row(
                      children: [
                        Flexible(
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Container(
                                margin: EdgeInsets.all(30),
                                child: Row(children: [
                                  Flexible(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      child: TextFormField(
                                        controller: _codigoBarras,
                                        cursorColor: Colors.grey[800],
                                        decoration: Decor(
                                            labelText: "Código de barras"),
                                      ),
                                    ),
                                    flex: 0,
                                  )
                                ]),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: TextFormField(
                                          maxLength: 60,
                                          controller: _descricaoProduto,
                                          cursorColor: Colors.grey[800],
                                          decoration: Decor(
                                              labelText:
                                                  "Descrição do produto"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: Row(children: [
                                    Container(
                                      child: Text(
                                        "Descrição da forma de pagamento: ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        "À vista R\$",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width: MediaQuery.of(context).size.width /
                                          15,
                                      child: TextFormField(
                                        controller: _avista,
                                        cursorColor: Colors.grey[800],
                                        decoration: Decor(
                                            labelText: "Valor", isDense: true),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          15,
                                      margin: EdgeInsets.only(left: 70),
                                      child: Text(
                                        "ou em até",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: SizedBox(
                                        child: TextFormField(
                                          controller: _aprazo,
                                          decoration: Decor(),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                18,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                      ),
                                    ),
                                  ])),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Tamanho numérico único",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child: SizedBox(
                                          child: DropdownButtonFormField(
                                            hint: Text("Ex: 34"),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              13,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outlined),
                                      onPressed: () {},
                                      tooltip:
                                          "Cadastrar novo tamanho numérico",
                                    ),
                                    Flexible(
                                        child: Container(
                                      margin: EdgeInsets.only(left: 50),
                                      child: Text(
                                        "Categoria",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    )),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child: SizedBox(
                                          child: GetBuilder(
                                            builder: (controller) =>
                                                DropdownButtonFormField(
                                                    items: controller
                                                        .listaCategorias),
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outlined),
                                      onPressed: () {},
                                      tooltip: "Cadastrar nova categoria",
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Tamanho escala",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      flex: 0,
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 94),
                                        child: SizedBox(
                                          child: DropdownButtonFormField(
                                            hint: Text("Ex: 34/35"),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              13,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outlined),
                                      onPressed: () {},
                                      tooltip: "Cadastrar novo tamanho escala",
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Tamanho medida",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      flex: 0,
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 89),
                                        child: SizedBox(
                                          child: DropdownButtonFormField(
                                            hint: Text("Ex: P"),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              13,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outlined),
                                      onPressed: () {},
                                      tooltip: "Cadastrar novo tamanho medida",
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text("Produto destaque"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.deepOrange[600]),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text("Salvar"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff38377b)),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                  ))
                            ],
                          ),
                          flex: 4,
                        ),
                        Flexible(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.all(30),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.getImage1();
                                        _images[0] = Obx(() => Container(
                                              child: Image.network(controller
                                                  .selectedImagePath1.value),
                                            ));
                                      },
                                      child: Text("Escolher imagem 1"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xfff58731)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          controller.getImage2();
                                          _images[1] = Obx(() => Container(
                                                child: Image.network(controller
                                                    .selectedImagePath2.value),
                                              ));
                                        },
                                        child: Text("Escolher imagem 2"),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xfff58731))),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          controller.getImage3();
                                          _images[2] = Obx(() => Container(
                                                child: Image.network(controller
                                                    .selectedImagePath3.value),
                                              ));
                                        },
                                        child: Text("Escolher imagem 3"),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xfff58731))),
                                  ),
                                  Obx(
                                    () => controller.selectedImagePath1.value ==
                                            null
                                        ? Center(
                                            child: Container(
                                              child: Text("Selecione a imagem"),
                                              margin: EdgeInsets.only(top: 20),
                                            ),
                                          )
                                        : Container(
                                            child: CarouselSlider(
                                                items: _images,
                                                options: CarouselOptions(
                                                  height: 400,
                                                  aspectRatio: 16 / 9,
                                                  viewportFraction: 0.8,
                                                  initialPage: 0,
                                                  enableInfiniteScroll: true,
                                                  reverse: false,
                                                  autoPlay: true,
                                                  autoPlayInterval:
                                                      Duration(seconds: 3),
                                                  autoPlayAnimationDuration:
                                                      Duration(
                                                          milliseconds: 800),
                                                  autoPlayCurve:
                                                      Curves.fastOutSlowIn,
                                                  enlargeCenterPage: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                )),
                                          ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
