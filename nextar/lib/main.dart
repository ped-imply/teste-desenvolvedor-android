import 'package:Nextar/controller/controller_cadastro_usuarios.dart';
import 'package:Nextar/view/view_cadastro_produtos.dart';
import 'package:Nextar/view/view_cadastro_usuarios.dart';
import 'package:Nextar/view/view_home.dart';
import 'package:Nextar/view/view_recuperar_senha.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nextar/view/view_editar_produtos.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/login',
    home: Principal(),
    getPages: [
      GetPage(name: '/login', page: () => Principal()),
      GetPage(
          name: '/recuperarSenha',
          page: () => ViewRecuperarSenha(),
          transition: Transition.rightToLeftWithFade),
      GetPage(
          name: '/cadastroUsuario',
          page: () => ViewCadastroUsuarios(),
          transition: Transition.rightToLeftWithFade),
      GetPage(name: '/principal', page: () => ViewHome()),
      GetPage(
          name: '/cadastroProdutos',
          page: () => ViewCadastroProdutos(),
          transition: Transition.zoom),
      GetPage(
          name: '/edicaoProdutos',
          page: () => ViewEdicaoProdutos(),
          transition: Transition.zoom)
    ],
  ));
}

class Principal extends StatelessWidget {
  final controllerLogin = Get.put(ControllerCadastroUsuarios());
  final TextEditingController _usuario = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(body: Container(child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 450) {
          return SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/background-waves.png'))),
                width: _width,
                height: _height,
                child: SingleChildScrollView(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/NEXTAR-logo.png')),
                        ),
                        width: _width / 3,
                        height: _height / 4,
                      ),
                      Container(
                        width: _width / 4,
                        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: TextFormField(
                          controller: _usuario,
                          cursorColor: Colors.redAccent,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Digite seu usuário",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      Container(
                        width: _width / 4,
                        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: TextFormField(
                          controller: _senha,
                          cursorColor: Colors.redAccent,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Digite sua senha",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: _width / 6,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          child: Text("Entrar"),
                          onPressed: () =>
                              controllerLogin.login(_usuario.text, _senha.text),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () => Get.toNamed('/cadastroUsuario'),
                          child: Text(
                            "É novo por aqui? Crie uma conta",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
          );
        } else {
          return SingleChildScrollView(
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/background-waves.png'))),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/NEXTAR-logo.png')),
                    ),
                    width: _width / 1.5,
                    height: _height / 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: TextFormField(
                        controller: _usuario,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                          hintText: "Digite seu usuário",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: TextFormField(
                        controller: _senha,
                        cursorColor: Colors.redAccent,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Digite sua senha",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)))),
                  ),
                  Container(
                      width: _width / 4,
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        child: Text("Entrar"),
                        onPressed: () =>
                            controllerLogin.login(_usuario.text, _senha.text),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () => Get.toNamed('/cadastroUsuario'),
                      child: Text("É novo por aqui? Crie uma conta",
                          style: TextStyle(color: Colors.red)),
                      splashColor: Colors.redAccent,
                    ),
                  )
                ],
              )),
            ),
          );
        }
      },
    )));
  }
}
