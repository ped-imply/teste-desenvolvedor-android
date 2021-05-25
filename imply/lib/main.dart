import 'package:flutter/material.dart';
import 'package:get/get.dart';

main() => runApp(GetMaterialApp(
      getPages: [GetPage(name: '/principal', page: () => Principal())],
      home: Principal(),
      initialRoute: '/principal',
    ));

class Principal extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(),
      ),
    );
  }
}
