import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/reservation.dart';
import '../models/workspace.dart'; // Importa o modelo Workspace

class ReservationService {
  final _storage = const FlutterSecureStorage();

  static const String _baseUrl = 'http://192.168.15.103:8080/reservation';

  // Lista de workspaces hardcoded, simulando dados locais do room_screen.dart
  final List<Map<String, dynamic>> _availableRooms = [
    {
      'id': 1,
      'name': 'Sala Privativa 1',
      'capacity': 4,
      'imagePath': 'assets/images/2de943ab-b3af-4451-a5c6-b275b23ed0d7.jpg',
      'description': 'Espaço tranquilo e reservado para equipes pequenas.',
    },
    {
      'id': 2,
      'name': 'Sala de Reunião Alpha',
      'capacity': 8,
      'imagePath': 'assets/images/158a420c-4099-4b7d-835f-061f03bbf473.jpg',
      'description':
          'Equipada com TV e quadro branco, ideal para apresentações.',
    },
    {
      'id': 3,
      'name': 'Mesa Privativa Beta',
      'capacity': 1,
      'imagePath': 'assets/images/22441bb1-c79e-466c-9a3f-8e7683546277.jpg',
      'description':
          'Estação de trabalho individual em ambiente compartilhado.',
    },
    {
      'id': 4,
      'name': 'Auditório Lab',
      'capacity': 20,
      'imagePath': 'assets/images/d05872d2-0f56-4aa8-85cc-6731e27ef119.jpg',
      'description': 'Espaço amplo para eventos e workshops.',
    },
  ];

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

Future<bool> createReservation(Reservation reservation) async {
  try {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) {
      debugPrint('Token JWT não encontrado');
      return false;
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/create'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'workspaceId': reservation.workspaceId,
        'userId': reservation.userId,
        'reservationDate': reservation.reservationDate.toIso8601String(),
        'status': reservation.status.name,
      }),
    );

    // Verificação BOOLEANA explícita
    final bool isSuccess = response.statusCode == 200 || response.statusCode == 201;
    
    if (isSuccess) {
      debugPrint('Reserva criada com sucesso');
      return true;
    } else {
      debugPrint('Falha ao criar reserva: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    debugPrint('Erro ao criar reserva: $e');
    return false;
  }
}

  Future<bool> updateReservation(int id, Reservation updateReservation) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$_baseUrl/$id');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updateReservation.toJson()),
    );
    if (response.statusCode == 200) {
      print('Reserva atualizada com sucesso!');
      return true;
    } else {
      print(
        'Erro ao atualizar reserva: ${response.statusCode} - ${response.body}',
      );
      return false;
    }
  }

  Future<bool> cancelReservation(int id) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$_baseUrl/$id/cancel');

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },  
    );

    if (response.statusCode == 200) {
      print('Reserva cancelada com sucesso!');
      return true;
    } else {
      print(
        'Erro ao cancelar reserva: ${response.statusCode} - ${response.body}',
      );
      return false;
    }
  }

Future<List<Reservation>> getReservationsByUserId(int userId) async {
  try {
    final token = await _storage.read(key: 'jwt_token');
    final response = await http.get(
      Uri.parse('$_baseUrl/user/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      debugPrint('Resposta bruta: ${response.body}'); // Para debug

      return data.map((item) {
        try {
          // Converte o objeto workspace para o formato esperado
          if (item is Map<String, dynamic> && item['workspace'] != null) {
            item['workspaceId'] = item['workspace']['workspaceId'];
          }

          return Reservation.fromJson(item);
        } catch (e) {
          debugPrint('Erro ao parsear reserva: $e\nItem: $item');
          throw Exception('Invalid reservation data');
        }
      }).toList();
    } else {
      throw Exception('Failed to load reservations: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error in getReservationsByUserId: $e');
    rethrow;
  }
}



  // Método para obter Workspace por ID (simulando dados locais)
  Future<Workspace?> getWorkspaceById(int id) async {
    final workspaceData = _availableRooms.firstWhere(
      (room) => room['id'] == id,
      orElse: () => {},
    );

    if (workspaceData.isNotEmpty) {
      return Workspace(
        workspaceId: workspaceData['id'] as int,
        name: workspaceData['name'] as String,
        capacity: workspaceData['capacity'] as int,
        location: 'Localização Padrão',
        status: 'Ativo',
      );
    } else {
      return null;
    }
  }

  Future<List<Workspace>> getAllWorkspace() async {
    return _availableRooms
        .map(
          (roomData) => Workspace(
            name: roomData['name'] as String,
            capacity: roomData['capacity'] as int,
            location: 'Localização Padrão',
            workspaceId: roomData['id'] as int,
            status: 'Ativo',
            description: roomData['description'] as String?,
          ),
        )
        .toList();
  }

  String getWorkspaceImagePatch(int id) {
    final workspaceData = _availableRooms.firstWhere(
      (room) => room['id'] == id,
      orElse: () => {},
    );
    return workspaceData['imagePath'] as String? ?? 'assets/images/default.jpg';
  }

  Future<int?> getUserId() async {
    final jsonStr = await _storage.read(key: 'user_data');
    if (jsonStr != null) {
      final json = jsonDecode(jsonStr);
      return json["id"];
    }
    return null;
  }
}
