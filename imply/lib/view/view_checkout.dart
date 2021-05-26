import 'package:flutter/material.dart';
import 'package:imply/controller/controller_produtos.dart';
import 'package:get/get.dart';

class ViewCheckout extends StatelessWidget {
  final _controller = Get.find<ControllerProdutos>();

  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: _width,
              child: ElevatedButton(
                onPressed: () => _controller.comprar(),
                child: Text("CONFIRMAR"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              )),
          GestureDetector(
            child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.red),
                child: Center(
                    child: Text("CANCELAR",
                        style: TextStyle(color: Colors.white)))),
            onTap: () => Get.back(),
          ),
        ],
      )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff005c92),
      ),
      body: Container(
          child: Obx(() => _controller.produtosCheckout.length == 0
              ? Center(
                  child: Text("Não há produtos em seu carrinho"),
                )
              : Column(
                  children: [
                    Container(
                      width: _width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Table(
                        columnWidths: {
                          0: FixedColumnWidth(150),
                          1: FixedColumnWidth(60),
                          2: FixedColumnWidth(65),
                          3: FixedColumnWidth(90),
                        },
                        children: [
                          TableRow(children: [
                            Text("Item",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            Text("Qtde.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            Text("Unit.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            Text("Total ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      width: _width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Table(
                        border: TableBorder(
                            horizontalInside:
                                BorderSide(width: 2, color: Colors.grey)),
                        columnWidths: {
                          0: FixedColumnWidth(150),
                          1: FixedColumnWidth(60),
                          2: FixedColumnWidth(65),
                          3: FixedColumnWidth(90),
                        },
                        children: _controller.produtosCheckout,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(width: 1, color: Colors.grey)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: _width,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("Total:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text(
                                    "R\$${_controller.total.value.toStringAsFixed(2).replaceAll('.', ',')}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )),
                  ],
                ))),
    );
  }
}
