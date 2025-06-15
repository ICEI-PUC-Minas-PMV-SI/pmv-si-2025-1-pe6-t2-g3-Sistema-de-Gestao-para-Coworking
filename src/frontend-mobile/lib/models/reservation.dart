import 'package:coworking_app/enums/reservation_status.dart';
import 'package:intl/intl.dart';

class Reservation {
  final int? id;
  final int workspaceId;
  final int userId;
  final DateTime reservationDate;
  final ReservationStatus status;
  final DateTime? canceledAt;

  Reservation({
    this.id,
    required this.workspaceId,
    required this.userId,
    required this.reservationDate,
    required this.status,
    this.canceledAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    // Extrai workspaceId do objeto workspace ou do campo direto
    final workspaceId = json['workspace'] != null 
        ? (json['workspace']['workspaceId'] as int?) 
        : (json['workspaceId'] as int?);
    
    // Converte a data que pode vir em formatos diferentes
    DateTime parseDate(dynamic dateValue) {
      if (dateValue is DateTime) return dateValue;
      if (dateValue is String) {
        try {
          return DateTime.parse(dateValue);
        } catch (e) {
          return DateTime.parse('$dateValue T00:00:00');
        }
      }
      return DateTime.now();
    }

    return Reservation(
      id: json['id'] as int?,
      workspaceId: workspaceId ?? 0, // Valor padrão se for nulo
      userId: json['userId'] as int? ?? 0, // Valor padrão se for nulo
      reservationDate: parseDate(json['reservationDate']),
      status: ReservationStatusExtension.fromString(json['status'] as String? ?? 'CONFIRMED'),
      canceledAt: json['canceledAt'] != null ? parseDate(json['canceledAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workspaceId': workspaceId,
      'userId': userId,
      'reservationDate': DateFormat('yyyy-MM-dd').format(reservationDate),
       'status': status.name,
      if (id != null) 'id': id,
      if (canceledAt != null) 'canceledAt': canceledAt!.toIso8601String(),
    };
  }
}


