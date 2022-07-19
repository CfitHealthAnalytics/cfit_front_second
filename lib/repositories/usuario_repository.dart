import 'dart:convert';

import 'package:cfit/adapters/usuario_transformer.dart';
import 'package:cfit/configs.dart';
import 'package:cfit/models/usuario.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class UsuariosRepository {
  List<Usuario> usuarios = [];

  UsuariosRepository();

  Future<List<Usuario>> getAll() async {
    final url = Uri.parse('$BASE_API/usuarios');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final usuariosList = jsonDecode(response.body) as List;

      for (var usuario in usuariosList) {
        usuarios.add(UsuarioTransformer.fromMap(usuario));
      }
    }
    // debugPrint('Quantidade Repository: ${usuarios.length}');
    return usuarios;
  }

  Future<void> store(String name, String email) async {}

  Future<void> delete(Usuario usuario) async {}
}
