import 'package:flutter/material.dart';

class Pedido extends StatelessWidget {
  ScrollController _controller = ScrollController();

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 1.3,
      child: Card(
        elevation: 10,
        child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(7),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Nº do pedido: 01"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Data: ${DateTime.now().toString()}"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Nome do cliente: Cliente sobrenome"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Telefone: (00)00000-0000"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Local de entrega: Avenida das avenidas, 251, Bairro, Município"),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: MediaQuery.of(context).size.height / 35),
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Card(
                          elevation: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 3,
                            child: Column(children: [
                              Container(
                                  child: Table(
                                columnWidths: {
                                  0: FixedColumnWidth(
                                      (MediaQuery.of(context).size.width / 12)),
                                  1: FixedColumnWidth(
                                      (MediaQuery.of(context).size.width / 18)),
                                  2: FixedColumnWidth(
                                      (MediaQuery.of(context).size.width / 12))
                                },
                                children: [
                                  TableRow(children: [
                                    Container(
                                      padding: EdgeInsets.all(18),
                                      child: Text(
                                        "Produto",
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
                                        "Qtd.",
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
                                        "Valor",
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
                                height:
                                    MediaQuery.of(context).size.height / 4.4,
                                width: MediaQuery.of(context).size.width,
                                child: Scrollbar(
                                  controller: _controller,
                                  child: SingleChildScrollView(
                                    controller: _controller,
                                    scrollDirection: Axis.vertical,
                                    child: Table(
                                        columnWidths: {
                                          0: FixedColumnWidth(
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  12)),
                                          1: FixedColumnWidth(
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  18)),
                                          2: FixedColumnWidth(
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  12))
                                        },
                                        children: List<TableRow>.generate(20,
                                            (index) {
                                          return TableRow(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.grey))),
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(18),
                                                  child: Text(
                                                    "Produto",
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
                                                    "2",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'HelveticaNeue',
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(18),
                                                  child: Text(
                                                    "R\$231,20",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily: 'Raleway',
                                                    ),
                                                  ),
                                                )
                                              ]);
                                        })),
                                  ),
                                  isAlwaysShown: true,
                                  hoverThickness: 10.0,
                                  thickness: 10.0,
                                  showTrackOnHover: true,
                                ),
                              )
                            ]),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Soma total do pedido"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 55),
                    Center(
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 10,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Receber"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff38377b)))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 90),
                          Container(
                              width: MediaQuery.of(context).size.width / 10,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Imprimir"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff58731)))),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 55),
                    Center(
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 10,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Faturar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.yellow[600]))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 90),
                          Container(
                              width: MediaQuery.of(context).size.width / 10,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Cancelar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red)))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
