enum ReservationStatus {
  CANCELLED,
  CONFIRMED,
  PENDING,
  UNKNOWN
}

extension ReservationStatusExtension on ReservationStatus {
  String get displayName {
    switch (this) {
      case ReservationStatus.CANCELLED:
        return 'Cancelada';
      case ReservationStatus.CONFIRMED:
        return 'Confirmada';
      case ReservationStatus.PENDING:
        return 'Pendente';
      case ReservationStatus.UNKNOWN:
        return 'Desconhecido';
    }
  }
  
  static ReservationStatus fromString(String status) {
    switch (status) {
      case 'CANCELLED':
        return ReservationStatus.CANCELLED;
      case 'CONFIRMED':
        return ReservationStatus.CONFIRMED;
      case 'PENDING':
        return ReservationStatus.PENDING;
      default:
        return ReservationStatus.UNKNOWN;
    }
  }
}