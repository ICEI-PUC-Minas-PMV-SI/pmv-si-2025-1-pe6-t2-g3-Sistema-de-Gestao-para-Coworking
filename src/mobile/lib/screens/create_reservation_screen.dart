import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:coworking_app/utils/app_colors.dart';
import '../models/reservation.dart';
import '../services/reservation_service.dart';
import '../enums/reservation_status.dart';
import '../global_keys.dart'; 

class CreateReservationScreen extends StatefulWidget {
  final int workspaceId;
  final String roomName;
  final int capacity;

  const CreateReservationScreen({
    super.key,
    required this.workspaceId,
    required this.roomName,
    required this.capacity,
  });

  @override
  State<CreateReservationScreen> createState() => _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  final _reservationService = ReservationService();
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  bool _isLoading = false;

  final DateFormat _displayDateFormat = DateFormat('dd-MM-yyyy');

  late final TextEditingController _workspaceNameController;
  late final TextEditingController _capacityController;

  @override
  void initState() {
    super.initState();
    _workspaceNameController = TextEditingController(text: widget.roomName);
    _capacityController = TextEditingController(text: widget.capacity.toString());
  }

  @override
  void dispose() {
    _workspaceNameController.dispose();
    _capacityController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate;
    try {
      initialDate = _displayDateFormat.parse(_dateController.text);
    } catch (e) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primaryOrange,
                  onPrimary: AppColors.white,
                  onSurface: AppColors.textDark,
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.primaryOrange),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = _displayDateFormat.format(picked);
      });
    }
  }

Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);

  try {
    final selectedDate = _displayDateFormat.parse(_dateController.text);
    final userId = await _reservationService.getUserId();

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro: usuário não autenticado')),
      );
      return;
    }

    final newReservation = Reservation(
      workspaceId: widget.workspaceId,
      userId: userId,
      reservationDate: selectedDate,
      status: ReservationStatus.CONFIRMED,
    );

    final success = await _reservationService.createReservation(newReservation);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reserva criada com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
      // Tenta chamar o refresh da ReservationsScreen via GlobalKey
      reservationsScreenKey.currentState?.refreshReservations();
      Navigator.pop(context, true); // Força atualização
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao criar reserva'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro: ${e.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    if (!mounted) return;
    setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Reserva')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildTextField(controller: _workspaceNameController, label: 'Nome da Sala', icon: Icons.meeting_room, readOnly: true),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _capacityController,
                label: 'Capacidade',
                icon: Icons.people,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('CRIAR RESERVA'),
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
    required bool readOnly,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Campo obrigatório';
        if (label == 'Capacidade') {
          final parsed = int.tryParse(value);
          if (parsed == null || parsed <= 0) return 'Número inválido';
        }
        return null;
      },
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dateController,
      onTap: () => _selectDate(context),
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Data (DD-MM-AAAA)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Selecione uma data';
        final regex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
        if (!regex.hasMatch(value)) return 'Formato de data inválido';
        return null;
      },
    );
  }
}

