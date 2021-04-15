import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  http.Response response;
  SharedPreferences prefs;

  var url = Uri.http('192.168.0.16:3001', '/login');
  var token;
  var dados;

  void login(var usuario, var senha, var context) async {
    prefs = await SharedPreferences.getInstance();

    try {
      response =
          await http.post(url, body: {"usuario": usuario, "senha": senha});
      dados = json.decode(response.body);
      token = dados["token"];
      prefs.setString("token", token);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Ocorreu um erro. Verifique sua conexão a Internet ou contate o suporte."),
          duration: Duration(milliseconds: 1700)));
    }

    if (response.statusCode == 200) {
      Get.toNamed("/menu");
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Dados inválidos, verifique seus dados e tente novamente."),
          duration: Duration(milliseconds: 1700)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Ocorreu um erro. Verifique sua conexão a Internet ou contate o suporte."),
          duration: Duration(milliseconds: 1700)));
    }
  }

  void deslogar() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Get.offAllNamed("/principal");
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") == null) {
      Get.offAllNamed("/principal");
    }
  }

  void ableToPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      Get.toNamed("/menu");
    }
  }
}
