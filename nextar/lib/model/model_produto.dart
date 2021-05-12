import 'dart:typed_data';
import 'package:nextar/model/errors/errors.dart';
import 'package:flutter/material.dart';

class Produto {
  Produto(
      {int idProduto,
      @required int idUser,
      @required String descricaoProduto,
      var preco,
      int quantidadeEstoque,
      @required String codigo,
      @required String dataCriacao,
      Uint8List imagem})
      : this._idProduto = idProduto,
        this._idUsuario = idUser,
        this._descricaoProduto = descricaoProduto,
        this._preco = preco,
        this._quantidadeEstoque = quantidadeEstoque,
        this._codigo = codigo,
        this._dataCriacao = dataCriacao,
        this._imagem = imagem;

  int _idProduto;
  int _idUsuario;
  String _descricaoProduto;
  var _preco;
  int _quantidadeEstoque;
  String _codigo;
  String _dataCriacao;
  Uint8List _imagem;

  Map<String, dynamic> toMap() {
    if (this._descricaoProduto.isEmpty ||
        this._descricaoProduto == '' ||
        this._descricaoProduto.length <= 0 ||
        this._descricaoProduto == null ||
        this._codigo.isEmpty ||
        this._codigo == '' ||
        this._codigo.length <= 0 ||
        this._codigo == null ||
        this._dataCriacao.isEmpty ||
        this._dataCriacao == '' ||
        this._dataCriacao.length <= 0 ||
        this._dataCriacao == null) {
      throw ProdutoException(
          causa:
              'descricaoProduto, codigo e dataCriacao nao podem ser nulos ou vazios');
    } else {
      Map<String, dynamic> map = Map();

      map['id_produto'] = this._idProduto;
      map['id_usuario'] = this._idUsuario;
      map['descricaoProduto'] = this._descricaoProduto;
      map['preco'] = this._preco;
      map['quantidade'] = this._quantidadeEstoque;
      map['codigo'] = this._codigo;
      map['data_criacao'] = this._dataCriacao;
      map['imagem_produto'] = this._imagem;

      return map;
    }
  }

  Produto.fromJson(Map<String, dynamic> json) {
    this._idProduto = json['id_produto'];
    this._idUsuario = json['id_usuario'];
    this._descricaoProduto = json['descricaoProduto'];
    this._preco = json['preco'];
    this._quantidadeEstoque = json['quantidade'];
    this._codigo = json['codigo'];
    this._dataCriacao = json['data_criacao'];
    this._imagem = json['imagem_produto'];
  }

  get idProduto => this._idProduto;
  get idUsuario => this._idUsuario;
  get descricaoProduto => this._descricaoProduto;
  get preco => this._preco;
  get quantidadeEstoque => this._quantidadeEstoque;
  get codigo => this._codigo;
  get dataCriacao => this._dataCriacao;
  get imagem => this._imagem;
}
