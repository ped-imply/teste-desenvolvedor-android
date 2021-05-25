import 'package:flutter/material.dart';
import 'package:nextar/model/errors/errors.dart';

class Usuario {
  Usuario(
      {@required String usuario, @required String cpf, @required String token})
      : this._usuario = usuario,
        this._cpf = cpf,
        this._token = token;

  final String _usuario;
  final String _cpf;
  final String _token;

  Map<String, dynamic> toMap() {
    if (this._usuario.isEmpty ||
        this._usuario == '' ||
        this._usuario.length <= 0 ||
        this._usuario == null ||
        this._cpf.isEmpty ||
        this._cpf == '' ||
        this._cpf.length <= 0 ||
        this._cpf == null ||
        this._token.isEmpty ||
        this._token == '' ||
        this._token.length <= 0 ||
        this._token == null) {
      throw UsuarioException(
          causa: 'usuario, cpf e token nao podem ser nulos ou vazios');
    } else {
      Map<String, dynamic> map = Map();
      map['usuario'] = this._usuario;
      map['cpf'] = this._cpf;
      map['token'] = this._token;
      return map;
    }
  }
}
