import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imply/controller/controller_produtos.dart';

main() => runApp(GetMaterialApp(
      getPages: [GetPage(name: '/principal', page: () => Principal())],
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
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 2, color: Color(0xff426fa5)),
                              borderRadius: BorderRadius.circular(4)),
                          width: 180,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text("Texto aqui"),
                              ),
                              VerticalDivider(
                                color: Colors.grey[600],
                                width: 10,
                              ),
                              Container(
                                child: Text("Texto aqui"),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Limpar")),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Confirmar")),
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
