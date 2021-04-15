import 'package:flutter/material.dart';

class CadastroFormaPagamento extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
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
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text("Formas de pagamento cadastradas")),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width / 6,
                              child: DropdownButtonFormField(
                                hint: Text("Bandeira"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Parcelamento"),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 10,
                              child: DropdownButtonFormField(
                                  hint: Text("Parcelamento")),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                        tooltip: "Editar forma de pagamento e parcelamento",
                      )),
                      Container(
                          child: IconButton(
                        icon: Icon(Icons.add_circle_outlined),
                        onPressed: () {},
                        tooltip: "Criar nova forma de pagamento e parcelamento",
                      ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    ]));
  }
}
