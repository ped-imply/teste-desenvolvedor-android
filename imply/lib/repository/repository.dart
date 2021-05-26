import 'package:imply/data/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class Repository {
  Future instance() async {
    Database instance = await DatabaseHelper.instance.database;
    return instance;
  }

  static final _tableCarrinho = "Carrinho";
  static final _columnDescricaoProdutoCarrinho = "descricao_produto";
  static final _columnValorUnitarioCarrinho = "valor";
  static final _columnQuantidadeCarrinho = "quantidade";

  static final _tableCompras = 'Compras';
  static final _columnDataHoraCompra = 'data_hora_compra';
  static final _columnDescricaoProdutoCompra = 'descricao_produto';
  static final _columnQuantidadeCompra = 'quantidade';
  static final _columnValorUnitarioCompra = 'valor_unitario';

  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  // Neste caso, estamos manipulando as tabelas de 'Usuarios' e 'Produtos'
  Future<int> insertCompra({@required Map<String, dynamic> row}) async {
    Database db = await instance();
    return await db.rawInsert('''INSERT INTO $_tableCompras(
          $_columnDataHoraCompra,
          $_columnDescricaoProdutoCompra,
          $_columnQuantidadeCompra,
          $_columnValorUnitarioCompra) 
        VALUES(?, ?, ?, ?)''', [
      row[_columnDataHoraCompra],
      row[_columnDescricaoProdutoCompra],
      row[_columnQuantidadeCompra],
      row[_columnValorUnitarioCompra],
    ]);
  }

  Future<int> insertCarrinho({@required Map<String, dynamic> row}) async {
    Database db = await instance();
    return await db.rawInsert('''INSERT INTO $_tableCarrinho(
          $_columnDescricaoProdutoCarrinho,
          $_columnQuantidadeCarrinho,
          $_columnValorUnitarioCarrinho) 
        VALUES(?, ?, ?)''', [
      row[_columnDescricaoProdutoCarrinho],
      row[_columnQuantidadeCarrinho],
      row[_columnValorUnitarioCarrinho],
    ]);
  }

  Future<int> updateCarrinho({@required Map<String, dynamic> row}) async {
    Database db = await instance();
    return await db.rawUpdate('''
    UPDATE $_tableCarrinho
    SET $_columnQuantidadeCarrinho = $_columnQuantidadeCarrinho + 1
    WHERE $_columnDescricaoProdutoCarrinho = ?
    ''', [row[_columnDescricaoProdutoCarrinho]]);
  }

  // Deleta uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha deletada.
  // Neste caso, estamos manipulando a tabela 'Produtos'
  Future<int> limparCarrinho() async {
    Database db = await instance();
    return await db.delete(_tableCarrinho,
        where: 'descricao_produto != ?', whereArgs: ['0']);
  }

  Future<List<Map<String, dynamic>>> queryValorTotalCarrinho() async {
    Database db = await instance();
    return await db.rawQuery('''
    SELECT SUM($_columnValorUnitarioCarrinho) as Total FROM $_tableCarrinho
    ''');
  }

  Future<List<Map<String, dynamic>>> queryQuantidadeCarrinho() async {
    Database db = await instance();
    return await db.rawQuery('''
    SELECT SUM($_columnQuantidadeCarrinho) as Total FROM $_tableCarrinho
    ''');
  }
}
