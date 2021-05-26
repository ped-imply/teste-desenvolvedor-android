import 'package:imply/data/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class Repository {
  /// Chama a instância do banco de dados
  Future instance() async {
    Database instance = await DatabaseHelper.instance.database;
    return instance;
  }

  static final _tableCarrinho = "Carrinho";
  static final _columnDescricaoProdutoCarrinho = "descricao_produto";
  static final _columnValorUnitarioCarrinho = "valor_unitario";
  static final _columnQuantidadeCarrinho = "quantidade";
  static final _columnValorTotalCarrinho = "valor_total";

  static final _tableCompras = 'Compras';
  static final _columnDataHoraCompra = 'data_hora_compra';
  static final _columnDescricaoProdutoCompra = 'descricao_produto';
  static final _columnQuantidadeCompra = 'quantidade';
  static final _columnValorUnitarioCompra = 'valor_unitario';
  static final _columnValorTotalCompra = 'valor_total';

  Future<int> insertCompra({@required Map<String, dynamic> row}) async {
    Database db = await instance();
    return await db.rawInsert('''INSERT INTO $_tableCompras(
          $_columnDataHoraCompra,
          $_columnDescricaoProdutoCompra,
          $_columnQuantidadeCompra,
          $_columnValorUnitarioCompra,
          $_columnValorTotalCompra) 
        VALUES(?, ?, ?, ?, ?)''', [
      row[_columnDataHoraCompra],
      row[_columnDescricaoProdutoCompra],
      row[_columnQuantidadeCompra],
      row[_columnValorUnitarioCompra],
      row[_columnValorTotalCompra]
    ]);
  }

  Future<List<Map<String, dynamic>>> queryExtrato() async {
    Database db = await instance();
    return await db.query(_tableCompras, columns: [
      _columnDataHoraCompra,
      _columnDescricaoProdutoCompra,
      _columnQuantidadeCompra,
      _columnValorUnitarioCompra,
      _columnValorUnitarioCompra
    ]);
  }

  Future<int> insertCarrinho({@required Map<String, dynamic> row}) async {
    Database db = await instance();
    return await db.rawInsert('''INSERT INTO $_tableCarrinho(
          $_columnDescricaoProdutoCarrinho,
          $_columnQuantidadeCarrinho,
          $_columnValorUnitarioCarrinho,
          $_columnValorTotalCarrinho) 
        VALUES(?, ?, ?, ?)''', [
      row[_columnDescricaoProdutoCarrinho],
      row[_columnQuantidadeCarrinho],
      row[_columnValorUnitarioCarrinho],
      row[_columnValorUnitarioCarrinho]
    ]);
  }

  Future<int> updateCarrinho({@required Map<String, dynamic> row}) async {
    Database db = await instance();
    return await db.rawUpdate('''
    UPDATE $_tableCarrinho
    SET $_columnQuantidadeCarrinho = $_columnQuantidadeCarrinho + 1,
    $_columnValorTotalCarrinho = $_columnValorTotalCarrinho + $_columnValorUnitarioCarrinho
    WHERE $_columnDescricaoProdutoCarrinho = ?
    ''', [row[_columnDescricaoProdutoCarrinho]]);
  }

  Future<int> limparCarrinho() async {
    Database db = await instance();
    return await db.delete(_tableCarrinho,
        where: 'descricao_produto != ?', whereArgs: ['0']);
  }

  Future<List<Map<String, dynamic>>> queryQuantidadeCarrinho(
      Map<String, dynamic> row) async {
    Database db = await instance();
    return await db.query(_tableCarrinho,
        columns: [_columnQuantidadeCarrinho],
        where: '$_columnDescricaoProdutoCarrinho = ?',
        whereArgs: [row[_columnDescricaoProdutoCarrinho]]);
  }

  Future<List<Map<String, dynamic>>> queryValorTotalCarrinho() async {
    Database db = await instance();
    return await db.rawQuery('''
    SELECT SUM($_columnValorTotalCarrinho) as total FROM $_tableCarrinho
    ''');
  }

  Future<List<Map<String, dynamic>>> queryAllCarrinho() async {
    Database db = await instance();
    return await db.query(_tableCarrinho, columns: [
      _columnDescricaoProdutoCarrinho,
      _columnQuantidadeCarrinho,
      _columnValorUnitarioCarrinho,
      _columnValorTotalCarrinho
    ]);
  }

  Future<List<Map<String, dynamic>>> queryAllQuantidadeCarrinho() async {
    Database db = await instance();
    return await db.rawQuery('''
    SELECT SUM($_columnQuantidadeCarrinho) as total FROM $_tableCarrinho
    ''');
  }
}
