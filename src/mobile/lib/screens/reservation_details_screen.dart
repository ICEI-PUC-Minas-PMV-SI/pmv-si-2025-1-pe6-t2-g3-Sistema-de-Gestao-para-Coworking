import 'package:coworking_app/enums/reservation_status.dart';
import 'package:flutter/material.dart';
import '../models/reservation.dart';
import 'package:coworking_app/services/reservation_service.dart';
import 'package:intl/intl.dart';

class ReservationDetailsScreen extends StatefulWidget {
  final Reservation reservation;

  const ReservationDetailsScreen({super.key, required this.reservation});

  @override
  State<ReservationDetailsScreen> createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  final ReservationService _reservationService = ReservationService();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  String _workspaceName = 'Carregando...';
  int _workspaceCapacity = 0;

  @override
  void initState() {
    super.initState();
    _loadWorkspaceDetails();
  }

  Future<void> _loadWorkspaceDetails() async {
    final workspace = await _reservationService.getWorkspaceById(widget.reservation.workspaceId);
    if (workspace != null) {
      setState(() {
        _workspaceName = workspace.name;
        _workspaceCapacity = workspace.capacity;
      });
    }
  }

@override
Widget build(BuildContext context) {
  debugPrint('Status da reserva: ${widget.reservation.status}');
  debugPrint('ID da reserva: ${widget.reservation.id}');

  return Scaffold(
    appBar: AppBar(title: const Text('Detalhes da Reserva')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem('Sala', _workspaceName),
          _buildDetailItem('Data', _dateFormat.format(widget.reservation.reservationDate)),
          _buildDetailItem('Capacidade', '$_workspaceCapacity pessoas'),
          _buildDetailItem('Status', widget.reservation.status.displayName),
          if (widget.reservation.status == ReservationStatus.CANCELLED &&
              widget.reservation.canceledAt != null)
            _buildDetailItem(
              'Cancelada em',
              _dateFormat.format(widget.reservation.canceledAt!),
            ),

          const SizedBox(height: 32),
          if (widget.reservation.status == ReservationStatus.CONFIRMED && 
              widget.reservation.id != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _navigateToEdit(context),
                child: const Text('Editar Reserva'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => _cancelReservation(context),
                child: const Text(
                  'CANCELAR RESERVA',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      '/editReservation',
      arguments: widget.reservation,
    );

    if (context.mounted && result == true) {
      Navigator.pop(context, true);
    }
  }

  void _cancelReservation(BuildContext context) async {
    final success = await _reservationService.cancelReservation(widget.reservation.id!);

    if (success) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reserva cancelada com sucesso!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context, true);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao cancelar reserva'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value, style: const TextStyle(fontSize: 18)),
          const Divider(),
        ],
      ),
    );
  }
}


