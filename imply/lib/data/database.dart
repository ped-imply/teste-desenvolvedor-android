import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "ImplySystem.db";
  static final _databaseVersion = 7;

  static final _tableCarrinho = "Carrinho";
  static final _columnDescricaoProdutoCarrinho = "descricao_produto";
  static final _columnValorUnitarioCarrinho = "valor_unitario";
  static final _columnQuantidadeCarrinho = "quantidade";
  static final _columnValorTotalCarrinho = "valor_total";

  static final _tableCompras = 'Compras';
  static final _columnIdCompra = 'id';
  static final _columnDataHoraCompra = 'data_hora_compra';
  static final _columnDescricaoProdutoCompra = 'descricao_produto';
  static final _columnQuantidadeCompra = 'quantidade';
  static final _columnValorUnitarioCompra = 'valor_unitario';
  static final _columnValorTotalCompra = 'valor_total';

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
          CREATE TABLE $_tableCarrinho (
            $_columnDescricaoProdutoCarrinho VARCHAR(100) NOT NULL,
            $_columnQuantidadeCarrinho INTEGER NOT NULL,
            $_columnValorUnitarioCarrinho DECIMAL (5,2) NOT NULL,
            $_columnValorTotalCarrinho DECIMAL (9,2) NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $_tableCompras (
            $_columnIdCompra INTEGER PRIMARY KEY NOT NULL,
            $_columnDataHoraCompra VARCHAR(20) NOT NULL,
            $_columnDescricaoProdutoCompra VARCHAR(100) NOT NULL,
            $_columnQuantidadeCompra INTEGER NOT NULL,
            $_columnValorUnitarioCompra DECIMAL(5,2) NOT NULL,
            $_columnValorTotalCompra DECIMAL(9,2) NOT NULL
          )
          ''');
  }
}
