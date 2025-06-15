// import 'package:flutter/material.dart';
// import 'reservation.dart';

// class ReservationManager {
//   static final List<Reservation> _reservations = [];
//   static final List<VoidCallback> _listeners = [];

//   // Retorna todas as reservas (ativas e canceladas)
//   static List<Reservation> get reservations => List.unmodifiable(_reservations);

//   // Retorna apenas reservas ativas
//   static List<Reservation> get activeReservations =>
//       _reservations.where((res) => res.status == 'Ativa').toList();

//   // Retorna apenas reservas canceladas que não devem ser removidas
//   static List<Reservation> get canceledReservations =>
//       _reservations.where((res) => res.status == 'Cancelada' && !res.shouldBeRemoved).toList();

//   static void addListener(VoidCallback listener) {
//     if (!_listeners.contains(listener)) {
//       _listeners.add(listener);
//     }
//   }

//   static void removeListener(VoidCallback listener) {
//     _listeners.remove(listener);
//   }

  // static void addReservation(Reservation reservation) {
  //   // Verifica se já existe uma reserva com o mesmo ID
  //   if (_reservations.any((res) => res.id == reservation.id)) {
  //     debugPrint('⚠️ Tentativa de adicionar reserva com ID duplicado: ${reservation.id}');
  //     return;
  //   }

  //   _reservations.add(reservation);
  //   _notifyListeners();
  //   debugPrint('✅ Reserva adicionada: ${reservation.roomName}');
  // }

  // static void updateReservation(Reservation updatedReservation) {
  //   final index = _reservations.indexWhere((r) => r.id == updatedReservation.id);
  //   if (index != -1) {
  //     _reservations[index] = updatedReservation;
  //     _notifyListeners();
  //     debugPrint('🔄 Reserva atualizada: ${updatedReservation.roomName}');
  //   } else {
  //     debugPrint('⚠️ Tentativa de atualizar reserva inexistente: ${updatedReservation.id}');
  //   }
  // }

  // static void  deleteReservation(String reservationId) {
  //   final index = _reservations.indexWhere((res) => res.id == reservationId);
  //   if (index != -1) {
  //     final reservation = _reservations[index];

  //     // Verifica se a reserva já está cancelada
  //     if (reservation.status == 'Cancelada') {
  //       debugPrint('⚠️ Tentativa de cancelar reserva já cancelada: ${reservationId}');
  //       return;
  //     }

  //     final updatedReservation = Reservation(
  //       id: reservation.id,
  //       roomName: reservation.roomName,
  //       capacity: reservation.capacity,
  //       date: reservation.date,
  //       time: reservation.time,
  //       status: 'Cancelada',
  //       userId: reservation.userId,
  //       canceledAt: DateTime.now(),
  //     );
  //     _reservations[index] = updatedReservation;
  //     _notifyListeners();
  //     debugPrint('🚫 Reserva cancelada: ${reservation.roomName}');
  //   } else {
  //     debugPrint('⚠️ Tentativa de cancelar reserva inexistente: ${reservationId}');
  //   }
  // }

  // static void cleanExpiredCancellations() {
  //   final initialCount = _reservations.length;
  //   _reservations.removeWhere((res) => res.shouldBeRemoved);

  //   if (_reservations.length < initialCount) {
  //     _notifyListeners();
  //     debugPrint('🧹 Removidas ${initialCount - _reservations.length} reservas canceladas expiradas');
  //   }
  // }

  // static void _notifyListeners() {
  //   // Cria uma cópia da lista para evitar problemas se um listener remover outro listener
  //   for (final listener in List.of(_listeners)) {
  //     try {
  //       listener();
  //     } catch (e) {
  //       debugPrint('⚠️ Erro ao notificar listener: $e');
  //     }
  //   }
  // }

  // // Método para verificar se existe uma reserva ativa para a mesma sala, data e horário
  // static bool hasActiveReservation(String roomName, String date, String time, {String? excludeId}) {
  //   return _reservations.any((res) =>
  //   res.status == 'Ativa' &&
  //       res.roomName == roomName &&
  //       res.date == date &&
  //       res.time == time &&
  //       (excludeId == null || res.id != excludeId)
  //   );
  // }

  // static void clear() {
  //   _reservations.clear();
  //   _notifyListeners();
  //   debugPrint('🗑️ Todas as reservas foram removidas');
  // }
// }