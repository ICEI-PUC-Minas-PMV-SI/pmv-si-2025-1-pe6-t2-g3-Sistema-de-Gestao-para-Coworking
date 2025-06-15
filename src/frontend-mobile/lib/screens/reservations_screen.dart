import 'package:coworking_app/enums/reservation_status.dart';
import 'package:coworking_app/models/workspace.dart';
import 'package:flutter/material.dart';
import 'package:coworking_app/services/reservation_service.dart';
import '../models/reservation.dart';
import 'package:intl/intl.dart';
import 'package:coworking_app/utils/app_colors.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => ReservationsScreenState();
}

class ReservationsScreenState extends State<ReservationsScreen> {
  final ReservationService _reservationService = ReservationService();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  late Future<List<Reservation>> _reservationsFuture;
  String _filterStatus = 'Todas';

  @override
  void initState() {
    super.initState();
    _reservationsFuture = _loadReservations();
  }

  Future<List<Reservation>> _loadReservations() async {
    try {
      final userId = await _reservationService.getUserId();
      if (userId != null) {
        final reservations = await _reservationService.getReservationsByUserId(userId);
        reservations.sort((a, b) => b.reservationDate.compareTo(a.reservationDate));
        return reservations;
      }
      return [];
    } catch (e) {
      if (e.toString().contains('Unauthorized')) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, '/login');
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar reservas: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }

  Future<void> refreshReservations() async { // Método tornado público
    setState(() {
      _reservationsFuture = _loadReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic _) {
        if (didPop) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            refreshReservations(); // Chama o método público
          });
        }
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshReservations, // Chama o método público
          child: FutureBuilder<List<Reservation>>(
            future: _reservationsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Erro: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: refreshReservations, // Chama o método público
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                );
              }

              final reservations = snapshot.data ?? [];
              final filteredReservations = _filterStatus == 'Todas'
                  ? reservations
                  : reservations.where((res) {
                      if (_filterStatus == 'Ativas') {
                        return res.status == ReservationStatus.CONFIRMED;
                      } else if (_filterStatus == 'Canceladas') {
                        return res.status == ReservationStatus.CANCELLED;
                      }
                      return res.status.name == _filterStatus;
                    }).toList();

              return Column(
                children: [
                  _buildFilterChips(theme),
                  Expanded(
                    child: _buildReservationsList(theme, filteredReservations),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: ["Todas", "Ativas", "Canceladas"].map((status) {
          final bool isSelected = _filterStatus == status;
          return FilterChip(
            label: Text(status),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _filterStatus = selected ? status : "Todas";
              });
            },
            labelStyle: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected ? AppColors.white : AppColors.textDark,
            ),
            backgroundColor: AppColors.white,
            selectedColor: theme.colorScheme.primary,
            checkmarkColor: AppColors.white,
            shape: StadiumBorder(
              side: BorderSide(
                color: isSelected ? theme.colorScheme.primary : AppColors.borderGrey,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReservationsList(ThemeData theme, List<Reservation> reservations) {
    final textTheme = theme.textTheme;

    if (reservations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _filterStatus == 'Todas'
                ? 'Você ainda não possui reservas.'
                : 'Nenhuma reserva encontrada com o status "$_filterStatus".',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(color: AppColors.textGrey),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        final bool isCancelled = reservation.status == ReservationStatus.CANCELLED;

        return FutureBuilder<Workspace?>(
          future: _reservationService.getWorkspaceById(reservation.workspaceId),
          builder: (context, snapshot) {
            final workspaceName = snapshot.hasData
                ? snapshot.data!.name
                : 'Sala ${reservation.workspaceId}';

            return Card(
              color: isCancelled
                  ? AppColors.darkBlue.withOpacity(0.7)
                  : theme.cardTheme.color,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                title: Text(
                  workspaceName,
                  style: isCancelled
                      ? theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.white,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.textGrey,
                        )
                      : theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textDark,
                          decoration: null,
                        ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Data: ${_dateFormat.format(reservation.reservationDate)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isCancelled ? AppColors.white : AppColors.textDark,
                      ),
                    ),
                    if (isCancelled && reservation.canceledAt != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Cancelada em: ${_dateFormat.format(reservation.canceledAt!)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.cancelRed.withOpacity(0.8),
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: _buildStatusChip(theme, reservation.status),
                onTap: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    '/reservationDetails',
                    arguments: reservation,
                  );
                  if (result == true) {
                    await refreshReservations(); // Chama o método público
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatusChip(ThemeData theme, ReservationStatus status) {
    Color chipColor;
    Color textColor;
    String label = status.displayName;

    switch (status) {
      case ReservationStatus.CONFIRMED:
        chipColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case ReservationStatus.CANCELLED:
        chipColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      default:
        chipColor = Colors.grey.shade300;
        textColor = Colors.grey.shade800;
    }

    return Chip(
      label: Text(label),
      labelStyle: theme.textTheme.bodySmall?.copyWith(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      visualDensity: VisualDensity.compact,
    );
  }
}

