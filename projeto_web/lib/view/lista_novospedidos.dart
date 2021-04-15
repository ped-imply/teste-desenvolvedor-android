import 'package:admin_newpedido/model/pedido.dart';
import 'package:flutter/material.dart';

class Pedidos extends StatelessWidget {
  ScrollController _controller = ScrollController();

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
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Pedido(),
                            Pedido(),
                            Pedido(),
                            Pedido(),
                            Pedido(),
                            Pedido(),
                            Pedido(),
                          ],
                        ),
                      ),
                      controller: _controller,
                    ),
                    controller: _controller,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    hoverThickness: 20.0,
                    thickness: 10.0,
                  )))
        ],
      ),
    );
  }
}
