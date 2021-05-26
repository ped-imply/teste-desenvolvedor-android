import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static final _databaseName = "NextarSystem.db";
  static final _databaseVersion = 10;

  static final _tableUsuarios = 'Usuarios';
  static final _columnIdUsuario = 'id_usuario';
  static final _columnUsuario = 'usuario';
  static final _columnCpf = 'cpf';
  static final _columnToken = 'token';

  static final _tableProdutos = 'Produtos';
  static final _columnFkIdUsuario = 'id_usuario';
  static final _columnIdProduto = 'id_produto';
  static final _columnDescricaoProduto = 'descricaoProduto';
  static final _columnPreco = 'preco';
  static final _columnQuantidade = 'quantidade';
  static final _columnCodigo = 'codigo';
  static final _columnImagemProduto = 'imagem_produto';
  static final _columnDataCriacao = 'data_criacao';

  // Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // tem somente uma referência ao banco de dados
  static Database _database;

  // instancia o db na primeira vez que for acessado
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreateTable);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreateTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableUsuarios (
            $_columnIdUsuario INTEGER PRIMARY KEY NOT NULL,
            $_columnUsuario VARCHAR(30) NOT NULL,
            $_columnCpf VARCHAR(14) UNIQUE NOT NULL,
            $_columnToken VARCHAR(50) NOT NULL
          )
    ''');

    await db.execute('''
          CREATE TABLE $_tableProdutos (
            $_columnIdProduto INTEGER PRIMARY KEY NOT NULL,
            $_columnFkIdUsuario INTEGER,
            $_columnDescricaoProduto VARCHAR(60) NOT NULL,
            $_columnPreco DECIMAL (9, 2),
            $_columnQuantidade INTEGER,
            $_columnCodigo VARCHAR(40) NOT NULL,
            $_columnImagemProduto BLOB,
            $_columnDataCriacao VARCHAR(20) NOT NULL,
            FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario) ON DELETE NO ACTION ON UPDATE NO ACTION
          )
          ''');
  }

  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  // Neste caso, estamos manipulando as tabelas de 'Usuarios' e 'Produtos'
  Future<int> insertUsuario({@required Map<String, dynamic> row}) async {
    Database db = await instance.database;
    return await db.rawInsert('''INSERT INTO $_tableUsuarios(
          $_columnUsuario,
          $_columnCpf,
          $_columnToken) 
        VALUES(?, ?, ?)''',
        [row[_columnUsuario], row[_columnCpf], row[_columnToken]]);
  }

  Future<int> insertProduto({@required Map<String, dynamic> row}) async {
    Database db = await instance.database;
    return await db.rawInsert('''INSERT INTO $_tableProdutos(
          $_columnFkIdUsuario, 
          $_columnDescricaoProduto, 
          $_columnPreco, 
          $_columnQuantidade, 
          $_columnCodigo,
          $_columnDataCriacao,
          $_columnImagemProduto) 
        VALUES(?, ?, ?, ?, ?, ?, ?)''', [
      row[_columnIdUsuario],
      row[_columnDescricaoProduto],
      row[_columnPreco],
      row[_columnQuantidade],
      row[_columnCodigo],
      row[_columnDataCriacao],
      row[_columnImagemProduto]
    ]);
  }

  // Deleta uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha deletada.
  // Neste caso, estamos manipulando a tabela 'Produtos'
  Future<int> deleteProduto({@required String codigoProduto}) async {
    Database db = await instance.database;
    return await db.delete(_tableProdutos,
        where: 'codigo = ?', whereArgs: [codigoProduto]);
  }

  // realiza uma busca de dados no banco de dados
  // em columns você insere um array de strings com as colunas desejadas
  // where você define a condição para a clausula where
  // em whereArgs você insere os parâmetros de filtro para os dados desejados
  // o valor de retorno é uma lista de maps com os valores solicitados
  Future<List<Map<String, dynamic>>> selectUsuarios(
      {@required List<String> columns,
      String where,
      List<String> whereArgs}) async {
    Database db = await instance.database;
    return await db.query(_tableUsuarios,
        columns: columns, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> selectProdutos(
      {@required List<String> columns,
      String where,
      List<String> whereArgs}) async {
    Database db = await instance.database;
    return await db.query(_tableProdutos,
        columns: columns, where: where, whereArgs: whereArgs);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRowsUsuarios() async {
    Database db = await instance.database;
    return await db.query(_tableUsuarios);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsProdutos(
      {@required int idUsuario}) async {
    Database db = await instance.database;
    return await db
        .query(_tableProdutos, where: 'id_usuario = ?', whereArgs: [idUsuario]);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsProdutosOrdemAlfabetica(
      {@required int idUsuario}) async {
    Database db = await instance.database;
    return await db.query(_tableProdutos,
        where: 'id_usuario = ?',
        whereArgs: [idUsuario],
        orderBy: _columnDescricaoProduto);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsProdutosPreco(
      {@required int idUsuario}) async {
    Database db = await instance.database;
    return await db.query(
      _tableProdutos,
      where: 'id_usuario = ?',
      whereArgs: [idUsuario],
      orderBy: '$_columnPreco DESC',
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRowsProdutosData(
      {@required int idUsuario}) async {
    Database db = await instance.database;
    return await db.query(
      _tableProdutos,
      where: 'id_usuario = ?',
      whereArgs: [idUsuario],
      orderBy: '$_columnDataCriacao DESC',
    );
  }

  // Assumimos aqui que a coluna cpf no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  // O mesmo se vale para a tabela 'Produtos'
  Future<int> updateUsuarios({@required Map<String, dynamic> row}) async {
    Database db = await instance.database;
    String cpf = row[_columnCpf];
    return await db.update(_tableUsuarios, row,
        where: '$_columnCpf = ?', whereArgs: [cpf]);
  }

  Future<int> updateProdutos({@required Map<String, dynamic> row}) async {
    Database db = await instance.database;
    int idProduto = row[_columnIdProduto];
    return await db.update(_tableProdutos, row,
        where: '$_columnIdProduto = ?', whereArgs: [idProduto]);
  }
}
