import 'package:flutter/material.dart';

class PedidosFaturados extends StatelessWidget {
  ScrollController _controller = ScrollController();

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(40),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black45,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ]),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Container(
                      child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(
                          (MediaQuery.of(context).size.width / 5.1)),
                      1: FixedColumnWidth(
                          (MediaQuery.of(context).size.width / 5.54)),
                      2: FixedColumnWidth(
                          (MediaQuery.of(context).size.width / 5.45)),
                    },
                    children: [
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            "Nº do Pedido",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            "Data",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            "Nome do cliente",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            "Celular",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                      ])
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Scrollbar(
                      controller: _controller,
                      child: SingleChildScrollView(
                        controller: _controller,
                        scrollDirection: Axis.vertical,
                        child: Table(
                            columnWidths: {
                              0: FixedColumnWidth(
                                  (MediaQuery.of(context).size.width / 7)),
                              1: FixedColumnWidth(
                                  (MediaQuery.of(context).size.width / 7)),
                              2: FixedColumnWidth(
                                  (MediaQuery.of(context).size.width / 7)),
                              3: FixedColumnWidth(
                                  (MediaQuery.of(context).size.width / 7)),
                              4: FixedColumnWidth(
                                  (MediaQuery.of(context).size.width / 7))
                            },
                            children: List<TableRow>.generate(20, (index) {
                              return TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.grey))),
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(18),
                                      child: Text(
                                        "$index",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(18),
                                      child: Text(
                                        "${DateTime.now().toString()}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(18),
                                      child: Text(
                                        "Carlos José",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(18),
                                      child: Text(
                                        "(00)00000-0000",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        padding: EdgeInsets.all(18),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Reimprimir"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xfff58731)),
                                        ))
                                  ]);
                            })),
                      ),
                      isAlwaysShown: true,
                      hoverThickness: 10.0,
                      thickness: 10.0,
                      showTrackOnHover: true,
                    ),
                  )
                ]))));
  }
}
