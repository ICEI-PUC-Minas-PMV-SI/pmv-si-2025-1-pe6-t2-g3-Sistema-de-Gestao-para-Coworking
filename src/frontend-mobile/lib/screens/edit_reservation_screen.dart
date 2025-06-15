import 'package:coworking_app/services/reservation_service.dart';
import 'package:flutter/material.dart';
import '../models/reservation.dart';
import 'package:intl/intl.dart';
import '../models/workspace.dart';

class EditReservationScreen extends StatefulWidget {
  final Reservation reservation;
  const EditReservationScreen({super.key, required this.reservation});

  @override
  State<EditReservationScreen> createState() => _EditReservationScreenState();
}

class _EditReservationScreenState extends State<EditReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _dateController;

  final ReservationService _reservationService = ReservationService();

  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  bool _isLoading = false;
  String _workspaceName = 'Carregando...';
  int _workspaceCapacity = 0;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: _dateFormat.format(widget.reservation.reservationDate),
    );
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
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = _dateFormat.format(pickedDate);
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final updatedReservation = Reservation(
          id: widget.reservation.id,
          workspaceId: widget.reservation.workspaceId,
          userId: widget.reservation.userId,
          reservationDate: _dateFormat.parse(_dateController.text),
          status: widget.reservation.status,
          canceledAt: widget.reservation.canceledAt,
        );

        final successUpdate = await _reservationService.updateReservation(
          widget.reservation.id!,
          updatedReservation,
        );

        if (!mounted) return;
        if (successUpdate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reserva atualizada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Falha ao atualizar reserva'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro inesperado: $e'), backgroundColor: Colors.red),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Reserva')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: TextEditingController(text: _workspaceName),
                label: 'Nome da Sala',
                icon: Icons.meeting_room,
                readOnly: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: TextEditingController(text: _workspaceCapacity.toString()),
                label: 'Capacidade',
                icon: Icons.people,
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              const SizedBox(height: 16),
              _buildDateField(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child:
                      _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('ATUALIZAR RESERVA'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        if (label == 'Capacidade') {
          final parsed = int.tryParse(value);
          if (parsed == null || parsed <= 0) {
            return 'Numero inválido';
          }
        }
        return null;
      },
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
        labelText: 'Data (DD-MM-AAAA)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: _selectDate,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Selecione uma data';
        }
        final dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
        if (!dateRegex.hasMatch(value)) {
          return 'Formato de data inválido';
        }
        return null;
      },
    );
  }
}


