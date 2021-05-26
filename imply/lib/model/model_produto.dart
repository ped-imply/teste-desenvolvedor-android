import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Produto {
  Produto(
      {@required String descricaoProduto,
      @required double valor,
      @required categoria,
      @required Uint8List imagem})
      : this._descricaoProduto = descricaoProduto,
        this._valor = valor,
        this._categoria = categoria,
        this._imagem = imagem;

  final String _descricaoProduto;
  final double _valor;
  final String _categoria;
  final Uint8List _imagem;

  Produto.fromJson(Map<String, dynamic> json)
      : this._descricaoProduto = json['dsc_produto'],
        this._valor = double.parse(json['valor']),
        this._categoria = json['dsc_produto_cat'],
        this._imagem = base64.decode(json['imagem']
            .replaceAll('}', '')
            .replaceAll('"', '')
            .replaceAll("\\", '')
            .split(',')
            .last);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['descricao_produto'] = this._descricaoProduto;
    map['valor'] = this._valor;
    map['quantidade'] = 1;

    return map;
  }

  get descricaoProduto => this._descricaoProduto;
  get valor => this._valor;
  get categoria => this._categoria;
  get imagem => this._imagem;
}
