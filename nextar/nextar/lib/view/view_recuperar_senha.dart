import 'package:nextar/controller/controller_cadastro_usuarios.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:get/get.dart';

class ViewRecuperarSenha extends StatelessWidget {
  final MaskedTextController _cpf =
      MaskedTextController(mask: '000.000.000-00');
  final TextEditingController _senha = TextEditingController();
  final TextEditingController _confirmarSenha = TextEditingController();

  final _controllerLogin = Get.find<ControllerCadastroUsuarios>();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(child: LayoutBuilder(builder: (context, constraints) {
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
                        maxLength: 14,
                        controller: _cpf,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                            hintText: 'Digite seu CPF',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Container(
                      width: _width / 4,
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: TextFormField(
                        controller: _senha,
                        obscureText: true,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                            hintText: 'Digite sua senha',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Container(
                      width: _width / 4,
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: TextFormField(
                        controller: _confirmarSenha,
                        obscureText: true,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                            hintText: 'Confirme sua senha',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: _width / 6,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        child: Text('Alterar senha'),
                        onPressed: () => _controllerLogin.recuperarSenha(
                            _cpf.text, _senha.text, _confirmarSenha.text),
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
                    maxLength: 14,
                    controller: _cpf,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.redAccent,
                    decoration: InputDecoration(
                      hintText: 'Digite seu CPF',
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
                        hintText: 'Digite sua senha',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)))),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: TextFormField(
                    controller: _confirmarSenha,
                    obscureText: true,
                    cursorColor: Colors.redAccent,
                    decoration: InputDecoration(
                        hintText: 'Confirme sua senha',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)))),
              ),
              Container(
                  width: _width / 2.5,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                    child: Text('Alterar senha'),
                    onPressed: () => _controllerLogin.recuperarSenha(
                        _cpf.text, _senha.text, _confirmarSenha.text),
                  )),
            ],
          )),
        ));
      }
    })));
  }
}
