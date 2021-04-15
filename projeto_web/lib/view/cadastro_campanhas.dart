import 'dart:io';

import 'package:admin_newpedido/controller/campanha_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';

class CadastroCamapanhas extends StatelessWidget {
  final CampanhaController controller = Get.put(CampanhaController());

  Widget build(BuildContext context) {
    var image1;
    var image2;
    var image3;
    var image4;

    List<Widget> imagens = [image1, image2, image3, image4];

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
                    )
                  ]),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.getImage1();
                                    imagens[0] = Obx(() => Container(
                                          child: Image.network(controller
                                              .selectedImagePath1.value),
                                        ));
                                  },
                                  child: Text("Inserir imagem 1"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731)),
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.getImage2();
                                    imagens[1] = Obx(() => Container(
                                          child: Image.network(controller
                                              .selectedImagePath2.value),
                                        ));
                                  },
                                  child: Text("Inserir imagem 2"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731)),
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.getImage3();
                                    imagens[2] = Obx(() => Container(
                                        child: Image.network(controller
                                            .selectedImagePath3.value)));
                                  },
                                  child: Text("Inserir imagem 3"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731)),
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.getImage4();
                                    imagens[3] = Obx(() => Container(
                                        child: Image.network(controller
                                            .selectedImagePath4.value)));
                                  },
                                  child: Text("Inserir imagem 4"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731)),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 10,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Remover imagem"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731))),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Salvar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff38377b)),
                                )),
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child:
                            Obx(() => controller.selectedImagePath1.value == ''
                                ? Center(child: Text("Selecione as imagens"))
                                : CarouselSlider(
                                    items: imagens,
                                    options: CarouselOptions(
                                      height: 400,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                    ))),
                        flex: 5,
                      ),
                    ],
                  ))
            ],
          ))),
    ]));
  }
}
