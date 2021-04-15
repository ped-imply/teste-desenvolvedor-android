import 'package:admin_newpedido/controller/login_controller.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:admin_newpedido/view/cadastro_campanhas.dart';
import 'package:admin_newpedido/view/cadastro_categorias.dart';
import 'package:admin_newpedido/view/cadastro_formapagamento.dart';
import 'package:admin_newpedido/view/cadastro_produtos.dart';
import 'package:admin_newpedido/view/cadastro_usuario.dart';
import 'package:admin_newpedido/view/lista_novospedidos.dart';
import 'package:admin_newpedido/view/lista_pedidosfaturados.dart';
import './view/cadastro_locaisentrega.dart';
import 'package:admin_newpedido/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

main() => runApp(GetMaterialApp(
      initialRoute: "/principal",
      routes: {
        "/principal": (context) => Principal(),
        "/menu": (context) => Menu(),
        "/menu/cadastroProdutos": (context) => CadastroProdutos(),
        "/menu/cadastroCampanhas": (context) => CadastroCamapanhas(),
        "/menu/cadastroCategorias": (context) => CadastroCategorias(),
        "/menu/cadastroFormaPagamento": (context) => CadastroFormaPagamento(),
        "/menu/cadastroUsuarios": (context) => CadastroUsuarios(),
        "/menu/cadastroLocaisEntrega": (context) => CadastroLocaisEntrega(),
        "/menu/pedidos": (context) => Pedidos(),
        "/menu/pedidosFaturados": (context) => PedidosFaturados()
      },
      home: Principal(),
    ));

class Principal extends StatelessWidget {
  final LoginController auth = Get.put(LoginController());

  OutlineInputBorder _decorated = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xfff36523), width: 0.0));
  UnderlineInputBorder _noLine =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  TextStyle estilo = GoogleFonts.openSans(
      color: Colors.deepOrange, fontSize: 60, fontWeight: FontWeight.w100);
  TextStyle estilo2 = GoogleFonts.openSans(
      color: Colors.deepOrange, fontSize: 40, fontWeight: FontWeight.w100);

  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();

  Widget build(BuildContext context) {
    auth.ableToPass();

    return Scaffold(
        body: Stack(children: [
      Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blue[100],
              Colors.white60,
              Colors.white70
            ])),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Color(0xffeeeeee)),
          )
        ],
      ),
      Center(
        widthFactor: 2.5,
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height / 20,
                            margin: EdgeInsets.fromLTRB(80, 0, 80, 0),
                            child: TextFormField(
                              decoration:
                                  Decor(labelText: "Insira seu usuário"),
                              controller: login,
                              style: TextStyle(color: Colors.deepOrange),
                            )),
                        Container(
                            height: MediaQuery.of(context).size.height / 20,
                            margin: EdgeInsets.fromLTRB(80, 10, 80, 5),
                            child: TextFormField(
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                                decoration:
                                    Decor(labelText: "Insira sua senha"),
                                controller: senha,
                                style: TextStyle(color: Colors.deepOrange))),
                      ],
                    ),
                  ),
                  Container(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            auth.login(login.text, senha.text, context);
                          },
                          child: Text("Logar"),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff00DD00))),
                      margin: EdgeInsets.all(5)),
                ],
              ),
            )),
      ),
    ]));
  }
}
