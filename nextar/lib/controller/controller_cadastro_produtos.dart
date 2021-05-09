import 'package:Nextar/database/database.dart';
import 'package:Nextar/model/model_produto.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:Nextar/view/widgets/view_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerCadastroProdutos extends GetxController {
  void onInit() {
    super.onInit();
    listarProdutos();
  }

  final DatabaseHelper _database = DatabaseHelper.instance;

  List<ViewCustomCard> produtosCard = <ViewCustomCard>[].obs;

  Uint8List _image = Uint8List(0);

  void cadastrarProduto(String descricaoProduto, String preco,
      String quantidadeEstoque, String codigo) async {
    if (descricaoProduto.trim().isNotEmpty && codigo.trim().isNotEmpty) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      final Produto _produto = Produto(
          idUser: _prefs.getInt('idUsuario'),
          descricaoProduto: descricaoProduto,
          preco: double.parse(preco.replaceAll(',', '.').replaceAll('R\$', '')),
          quantidadeEstoque: int.parse(quantidadeEstoque),
          codigo: codigo,
          dataCriacao: DateTime.now().toString(),
          imagem: this._image);

      final int _resposta =
          await _database.insertProduto(row: _produto.toMap());

      if (_resposta > 0) {
        Get.back();
        Get.snackbar('Sucesso', 'Produto cadastrado com sucesso!');
        listarProdutos();
      } else {
        Get.snackbar('Erro',
            'Sentimos muito. Ocorreu um erro. Contate o suporte ou tente novamente mais tarde');
      }
    } else {
      Get.snackbar(
          'Divergência', 'Preencha os campos obrigatórios corretamente');
    }
  }

  void obterImagemProduto() async {
    final _picker = ImagePicker();

    final _pickedFile = await _picker.getImage(source: ImageSource.gallery);

    _image = await _pickedFile.readAsBytes();
  }

  Future<List<ViewCustomCard>> listarProdutos() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    produtosCard.clear();

    int idUsuario = _prefs.getInt('idUsuario');

    List<Map<String, dynamic>> resposta =
        await _database.queryAllRowsProdutos(idUsuario: idUsuario);

    for (var produto in resposta) {
      var p = Produto.fromJson(produto);
      produtosCard.add(ViewCustomCard(
          produto: Produto(
              idUser: _prefs.getInt('idUsuario'),
              descricaoProduto: p.descricaoProduto,
              preco: p.preco,
              quantidadeEstoque: p.quantidadeEstoque,
              codigo: p.codigo,
              dataCriacao: p.dataCriacao,
              imagem: p.imagem)));
    }
    return produtosCard;
  }

  void editarProduto() {}

  void deletarProduto() {}

  void filtrarProdutoPorData() {}

  void filtrarProdutoPorPreco() {}

  void filtrarProdutoPorOrdemAlfabetica() {}
}
