import 'package:Nextar/controller/controller_cadastro_produtos.dart';
import 'package:Nextar/model/model_produto.dart';
import 'package:Nextar/view/widgets/view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewHome extends StatelessWidget {
  final _controllerCadastroProdutos = Get.put(ControllerCadastroProdutos());

  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    Widget narrowBody =
        Obx(() => _controllerCadastroProdutos.produtosCard.length == 0
            ? Center(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Bem-vindo, usuario. Parece que você ainda não tem nenhum produto cadastrado. Aperte o botão + para começar.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          color: Colors.redAccent, fontSize: 18),
                    )))
            : Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    children: _controllerCadastroProdutos.produtosCard,
                  ),
                ),
              ));

    Widget largeBody =
        Obx(() => _controllerCadastroProdutos.produtosCard.length == 0
            ? Center(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Bem-xvindo, usuario. Parece que você ainda não tem nenhum produto cadastrado. Aperte o botão + para começar.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          color: Colors.redAccent, fontSize: 18),
                    )))
            : Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    children: _controllerCadastroProdutos.produtosCard,
                  ),
                ),
              ));

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 450) {
        return WillPopScope(
            child: Scaffold(
                drawer: Drawer(),
                appBar: AppBar(
                  actions: [
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          largeBody = FutureBuilder(
                            future:
                                _controllerCadastroProdutos.listarProdutos(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.redAccent),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: _width,
                                  height: _height,

                                    child: Center(
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        alignment: WrapAlignment.spaceBetween,
                                        children: snapshot.data.value,
                                      ),
                                    ),

                                );
                              }
                            },
                          );
                        }),
                    IconButton(
                        icon: Icon(Icons.filter_list_outlined),
                        onPressed: () {}),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => Get.toNamed('/cadastroProdutos'),
                    )
                  ],
                  iconTheme: IconThemeData(color: Colors.redAccent),
                  title: Image.asset('assets/NEXTAR-logo.png',
                      width: _width / 10, height: _height / 10),
                  backgroundColor: Colors.white,
                ),
                body: largeBody),
            onWillPop: () {});
      } else {
        return WillPopScope(
            child: Scaffold(
              drawer: Drawer(),
              appBar: AppBar(
                actions: [
                  IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        narrowBody = FutureBuilder(
                          future: _controllerCadastroProdutos.listarProdutos(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.redAccent),
                                ),
                              );
                            } else {
                              return Container(
                                width: _width,
                                height: _height,

                                  child: Center(
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      alignment: WrapAlignment.spaceBetween,
                                      children: snapshot.data.value,
                                    ),
                                  ),
                                );

                            }
                          },
                        );
                      }),
                  IconButton(
                      icon: Icon(Icons.filter_list_outlined), onPressed: () {}),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => Get.toNamed('/cadastroProdutos'),
                  )
                ],
                iconTheme: IconThemeData(color: Colors.redAccent),
                title: Image.asset('assets/NEXTAR-logo.png',
                    width: _width / 4, height: _height / 4),
                backgroundColor: Colors.white,
              ),
              body: narrowBody,
            ),
            onWillPop: () {});
      }
    });
  }
}
