import 'package:coworking_app/services/reservation_service.dart';
import 'package:coworking_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../components/header.dart';
import 'rooms_screen.dart';
import '../global_keys.dart';
import 'reservations_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  // Usando constantes para simular dados do usuário
  final _reservationService = ReservationService();

  // Telas correspondentes a cada aba
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Inicialização das telas com os dados do usuário
    _screens = [
      const RoomsScreen(),
      ReservationsScreen(key: reservationsScreenKey),
      const AboutScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: _getAppBarTitle(),
        showBackButton: false,
        onProfileTap: () => _navigateToProfile(context),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Salas Disponíveis';
      case 1:
        return 'Minhas Reservas';
      case 2:
        return 'Sobre';
      default:
        return 'Belo Space'; 
    }
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/profile',
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: AppColors.textGrey,
      backgroundColor: AppColors.white,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      
      selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: theme.textTheme.bodySmall,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.meeting_room_outlined),
          activeIcon: Icon(Icons.meeting_room),
          label: 'Salas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          activeIcon: Icon(Icons.calendar_today),
          label: 'Reservas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          activeIcon: Icon(Icons.info),
          label: 'Sobre',
        ),
      ],
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_center_outlined,
              size: 80,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Belo Space Coworking',
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Versão 1.0.0',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
            ),
            const SizedBox(height: 24),
            Text(
              'Aplicativo para visualização e gerenciamento simulado de reservas de salas de coworking.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),
            Text(
              '© 2025 Belo Space',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}