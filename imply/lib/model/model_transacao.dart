import 'package:flutter/material.dart';

class Transacao {
  Transacao(
      {@required String descricaoProduto,
      @required int quantidade,
      @required double valorUnitarioProduto,
      @required double valorTotalProduto})
      : this._descricaoProduto = descricaoProduto,
        this._quantidade = quantidade,
        this._valorUnitarioProduto = valorUnitarioProduto,
        this._valorTotalProduto = valorTotalProduto;

  String _dataHoraCompra = DateTime.now().toString();
  String _descricaoProduto;
  int _quantidade;
  double _valorUnitarioProduto;
  double _valorTotalProduto;

  Transacao.fromJson(Map<String, dynamic> json) {
    this._descricaoProduto = json['descricao_produto'];
    this._quantidade = json['quantidade'];
    this._valorUnitarioProduto = json['valor_unitario'];
    this._valorTotalProduto = json['valor_total'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['data_hora_compra'] = this._dataHoraCompra;
    map['descricao_produto'] = this._descricaoProduto;
    map['quantidade'] = this._quantidade;
    map['valor_unitario'] = this._valorUnitarioProduto;
    map['valor_total'] = this._valorTotalProduto;

    return map;
  }
}
