import 'package:flutter/material.dart';
import '../model/decoration_textfield.dart';

class CadastroLocaisEntrega extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
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
              child: Container(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: DropdownButtonFormField(
                                        hint: Text("Cidade"),
                                      )),
                                  Container(
                                      child: IconButton(
                                    icon: Icon(Icons.add_circle_outlined),
                                    tooltip: "Cadastrar nova cidade",
                                  )),
                                ]),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 60,
                          ),
                          Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: TextFormField(
                                        cursorColor: Colors.grey[800],
                                        decoration: Decor(labelText: "Bairro"),
                                      )),
                                  Container(
                                      child: IconButton(
                                    icon: Icon(Icons.add_circle_outlined),
                                    tooltip: "Cadastrar novo bairro",
                                  )),
                                ]),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 60,
                          ),
                          Center(
                            widthFactor: 4.25,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                child: TextFormField(
                                  cursorColor: Colors.grey[800],
                                  decoration:
                                      Decor(labelText: "Taxa de entrega R\$"),
                                )),
                          ),
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
                                width: MediaQuery.of(context).size.width / 4.3,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Salvar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff38377b)),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 15,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 4.3,
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
