import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProdutosController extends GetxController {
  var selectedImagePath1 = ''.obs;
  var selectedImagePath2 = ''.obs;
  var selectedImagePath3 = ''.obs;

  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();

  var urlCadastroProduto = Uri.http("192.168.0.16:3001", "/cadastrarProduto");
  var urlListarCategorias = Uri.http("192.168.0.16:3001", "/listarCategorias");

  List listaCategorias = [].obs;

  void getImage1() async {
    final pickedFile1 = await picker1.getImage(source: ImageSource.gallery);

    if (pickedFile1 != null) {
      selectedImagePath1.value = pickedFile1.path;
    } else {
      print("No image selected");
    }
  }

  void getImage2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.gallery);

    if (pickedFile2 != null) {
      selectedImagePath2.value = pickedFile2.path;
    } else {
      print("No image selected");
    }
  }

  void getImage3() async {
    final pickedFile3 = await picker3.getImage(source: ImageSource.gallery);

    if (pickedFile3 != null) {
      selectedImagePath3.value = pickedFile3.path;
    } else {
      print("No image selected");
    }
  }

  void clearImages() {
    selectedImagePath1.value = null;
    selectedImagePath2.value = null;
    selectedImagePath3.value = null;
  }

  void salvar(
      var context,
      var codigoBarras,
      var descricaoProduto,
      var descricaoPagamento,
      var valor,
      var nome_categoria,
      var destaque,
      var tamanhos,
      var imagens) async {
    var formData = dio.FormData.fromMap({
      "codigoProduto": codigoBarras,
      "descricaoProduto": descricaoProduto,
      "nome_categoria": nome_categoria,
      "valor": valor,
      "destaque": destaque,
      "descricao_pagamento": descricaoPagamento,
      "tamanho": tamanhos,
      "produto_imagens": [
        selectedImagePath1.value != null || selectedImagePath1.value != ""
            ? dio.MultipartFile.fromFileSync(selectedImagePath1.value,
                filename: 'image1.png')
            : null,
        selectedImagePath2.value != null || selectedImagePath2.value != ""
            ? dio.MultipartFile.fromFileSync(selectedImagePath1.value,
                filename: 'image2.png')
            : null,
        selectedImagePath3.value != null || selectedImagePath3.value != ""
            ? dio.MultipartFile.fromFileSync(selectedImagePath1.value,
                filename: 'image3.png')
            : null,
      ],
    });

    var response = await dio.Dio().post(
        "https://www.api.lekacalcados.lojaonline.eco.br/cadastrarProduto",
        data: formData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Produto cadastrado com sucesso"),
        duration: Duration(milliseconds: 1700),
      ));
    } else if (response.statusCode == 401) {
      Get.offAllNamed("/principal");
    } else {}
  }

  listarCategorias() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response =
        await http.get(urlListarCategorias, headers: {"token": token});
    var dados = json.decode(response.body);

    for (var i = 0; i < dados.length; i++) {
      listaCategorias.add(DropdownMenuItem(
        child: Text(dados[i]["nome_categoria"]),
        value: dados[i]["nome_categoria"],
      ));
    }
    update(listaCategorias);
  }

  void listarTamanhoNumerico() {}

  void listarTamanhoEscala() {}

  void listarTamanhoMedida() {}
}
