import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';

class AuthService {
  static const _baseUrl = 'http://10.0.2.2:8080/auth';
  static final _storage = FlutterSecureStorage();

  /// Faz login e retorna um Map com token e user, ou null se falhar
static Future<bool?> login(String email, String password) async {
  try {
    final res = await http
        .post(
          Uri.parse('$_baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(const Duration(seconds: 10));

    if (res.statusCode == 200) {
      final responseBody = jsonDecode(res.body);
      debugPrint('Resposta completa da API: ${res.body}');

      // Verifica se tem a estrutura esperada
      if (responseBody['token'] == null || responseBody['user'] == null) {
        throw Exception('Estrutura de resposta inválida');
      }

      final user = responseBody['user'];
      
      final userData = {
        'token': responseBody['token'],
        'email': user['email'],
        'fullName': user['fullName'],
        'id': user['id'],
        'role': user['role'],
      };

      await _storage.write(key: 'jwt_token', value: userData['token']);
      await _storage.write(key: 'user_data', value: jsonEncode(userData));
      debugPrint('Dados do usuário armazenados: $userData');

      return true;
    } else {
      debugPrint('Login failed: ${res.statusCode} - ${res.body}');
      return false;
    }
  } catch (e) {
    debugPrint('Login error: $e');
    return null;
  }
}

static Future<Map<String, dynamic>> register(
  String fullName,
  String email,
  String password,
) async {
  try {
    final url = Uri.parse('$_baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
        'role': 'USER',
      }),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Registro realizado com sucesso!',
        'data': responseBody,
      };
    } else if (response.statusCode == 409) {
      return {
        'success': false,
        'message': responseBody['message'] ?? 'Usuário já existe',
      };
    } else if (response.statusCode == 400) {
      return {
        'success': false,
        'message': responseBody['message'] ?? 'Dados inválidos',
      };
    } else {
      return {
        'success': false,
        'message': 'Erro desconhecido: ${response.statusCode}',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'Erro de conexão: ${e.toString()}',
    };
  }
}
}
