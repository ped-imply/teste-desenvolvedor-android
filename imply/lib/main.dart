import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imply/controller/controller_produtos.dart';
import 'package:imply/view/view_checkout.dart';

main() => runApp(GetMaterialApp(
      title: "imply",
      color: Color(0xff005c92),
      getPages: [
        GetPage(name: '/principal', page: () => Principal()),
        GetPage(name: '/checkout', page: () => ViewCheckout())
      ],
      home: Principal(),
      initialRoute: '/principal',
    ));

class Principal extends StatelessWidget {
  Widget build(BuildContext context) {
    final _controller = Get.put(ControllerProdutos());
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Container(
      child: Container(
          child: DefaultTabController(
              length: 2,
              child: Scaffold(
                  bottomNavigationBar: Container(
                    height: 60,
                    decoration: BoxDecoration(color: Color(0xff005c92)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 2, color: Color(0xff426fa5)),
                              borderRadius: BorderRadius.circular(4)),
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Obx(() => _controller.total.value ==
                                            0.0 ||
                                        _controller.total.value == null
                                    ? Text("R\$: 0,00",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold))
                                    : Text(
                                        "R\$: ${_controller.total.value.toStringAsFixed(2).replaceAll('.', ',')}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold))),
                              ),
                              VerticalDivider(
                                color: Colors.grey[600],
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Obx(() => _controller.quantidade.value ==
                                            0 ||
                                        _controller.quantidade.value == null
                                    ? Text("Quantidade: 0")
                                    : Text(
                                        "Quantidade: ${_controller.quantidade.value}")),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: ElevatedButton(
                                  onPressed: () => _controller.limparCarrinho(),
                                  child: Text("Limpar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('/checkout');
                                    _controller.obterProdutosCarrinho();
                                  },
                                  child: Text("OK"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.yellowAccent[700],
                    centerTitle: true,
                    title: Image.asset("assets/i-imply.png",
                        width: 130, height: 130),
                    bottom: TabBar(indicatorColor: Color(0xff005c92), tabs: [
                      Tab(
                        child: Text(
                          "Lanches",
                          style: TextStyle(color: Color(0xff005c92)),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Bebidas",
                          style: TextStyle(color: Color(0xff005c92)),
                        ),
                      ),
                    ]),
                  ),
                  body: TabBarView(
                    children: [
                      Obx(() => _controller.cardsComidas.isEmpty ||
                              _controller.cardsComidas == [] ||
                              _controller.cardsComidas.length == 0
                          ? Center(
                              child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff005c92)),
                            ))
                          : Container(
                              height: _height,
                              width: _width,
                              child: Center(
                                  child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: 5,
                                  children: _controller.cardsComidas,
                                ),
                              )))),
                      Obx(() => _controller.cardsBebidas.isEmpty ||
                              _controller.cardsBebidas == [] ||
                              _controller.cardsBebidas.length == 0
                          ? Center(
                              child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff005c92)),
                            ))
                          : Container(
                              height: _height,
                              width: _width,
                              child: Center(
                                  child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: 5,
                                  children: _controller.cardsBebidas,
                                ),
                              )))),
                    ],
                  )))),
    );
  }
}
