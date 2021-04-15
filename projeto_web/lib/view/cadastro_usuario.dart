import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:flutter/material.dart';

class CadastroUsuarios extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(40),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ]),
              child: Container(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 15,
                              child: TextFormField(
                                cursorColor: Colors.grey[800],
                                decoration: Decor(labelText: "Código"),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 60,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                cursorColor: Colors.grey[800],
                                decoration: Decor(labelText: "Login"),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 60,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                cursorColor: Colors.grey[800],
                                decoration: Decor(labelText: "Senha"),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 60,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                cursorColor: Colors.grey[800],
                                decoration: Decor(labelText: "Confirmar senha"),
                              )),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Salvar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff38377b)),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Novo"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731)),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Inativar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Buscar"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff62ba51))))
                          ],
                        ))
                  ],
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
