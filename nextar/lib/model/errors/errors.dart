import 'package:flutter/material.dart';

class ProdutoException implements Exception {
  final String _causa;
  ProdutoException({@required String causa}) : this._causa = causa;
}

class UsuarioException implements Exception {
  final String _causa;
  UsuarioException({@required String causa}) : this._causa = causa;
}
