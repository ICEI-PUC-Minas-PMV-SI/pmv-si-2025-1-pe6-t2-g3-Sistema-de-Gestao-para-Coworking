import 'package:coworking_app/services/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:coworking_app/models/workspace.dart';
import 'package:coworking_app/utils/app_colors.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  late Future<List<Workspace>> _workspaceFuture;
  DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _reservationService = ReservationService();

  @override
  void initState() {
    super.initState();
    _workspaceFuture = _reservationService.getAllWorkspace(); 
  }

  void _selectRoom(Workspace workspace) {
    Navigator.pushNamed(
      context,
      '/createReservation',
      arguments: {'id': workspace.workspaceId, 'roomName': workspace.name, 'capacity': workspace.capacity},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final textTheme = theme.textTheme;

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: FutureBuilder<List<Workspace>>(
  future: _workspaceFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Erro ao carregar as salas: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('Nenhuma _reservationFuture disponível'));
    } else {
      final workspaces = snapshot.data!;
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: workspaces.length,
        itemBuilder: (context, index) {
          final room = workspaces[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            color: AppColors.darkBlue,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      _reservationService.getWorkspaceImagePatch(room.workspaceId!),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    room.name,
                    style: textTheme.titleLarge?.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people_outline, color: AppColors.textGrey, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${room.capacity} pessoa(s)',
                        style: textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    room.description ?? 'Sem descrição.',
                    style: textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _selectRoom(room),
                      child: const Text("Reservar"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  },
),
);
}}

