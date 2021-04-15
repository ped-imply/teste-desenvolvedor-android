import 'dart:html';

import 'package:admin_newpedido/controller/login_controller.dart';
import 'package:admin_newpedido/model/cardMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  final auth = Get.find<LoginController>();

  Widget build(BuildContext context) {
    auth.checkToken();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff38377b),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width / 10,
            height: MediaQuery.of(context).size.height,
            child: ElevatedButton(
              onPressed: () {
                auth.deslogar();
              },
              child: Text("Sair"),
              style: ElevatedButton.styleFrom(primary: Colors.green[800]),
            ),
          ),
        ],
        title: Center(
          child: Text("Projeto web"),
        ),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardMenu(
                            color: Colors.red,
                            icon: Icons.article,
                            text: "Pedidos",
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            onTap: () => Get.toNamed("/menu/pedidos"),
                          ),
                          CardMenu(
                              icon: Icons.shopping_basket,
                              color: Colors.deepOrange,
                              text: "Cadastro de produtos",
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              onTap: () {
                                Get.toNamed("/menu/cadastroProdutos");
                              }),
                          CardMenu(
                              icon: Icons.announcement,
                              color: Colors.green[900],
                              text: "Imagens de campanha",
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              onTap: () =>
                                  Get.toNamed("/menu/cadastroCampanhas"))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardMenu(
                            icon: Icons.category,
                            color: Colors.orange,
                            text: "Cadastro de categorias",
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            onTap: () =>
                                Get.toNamed("/menu/cadastroCategorias"),
                          ),
                          CardMenu(
                            icon: Icons.credit_card,
                            color: Colors.blue,
                            text: "Cadastro de bandeiras",
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            onTap: () =>
                                Get.toNamed("/menu/cadastroFormaPagamento"),
                          ),
                          CardMenu(
                            icon: Icons.person_add,
                            color: Colors.purple,
                            text: "Cadastro de usuários",
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            onTap: () => Get.toNamed("/menu/cadastroUsuarios"),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardMenu(
                            icon: Icons.location_on,
                            color: Colors.indigo,
                            text: "Locais de entrega",
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            onTap: () =>
                                Get.toNamed("/menu/cadastroLocaisEntrega"),
                          ),
                          CardMenu(
                            //icon: Icons.location_on,
                            color: Colors.pink,
                            text: "Pedidos faturados",
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            icon: Icons.monetization_on_outlined,
                            onTap: () => Get.toNamed("/menu/pedidosFaturados"),
                          ),
                          CardMenu(
                              color: Colors.cyan,
                              text: "Relatórios",
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              icon: Icons.bar_chart)
                        ])
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
