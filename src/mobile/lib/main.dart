import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/rooms_screen.dart';
import 'screens/create_reservation_screen.dart';
import 'screens/reservation_details_screen.dart';
import 'screens/edit_reservation_screen.dart';
import 'models/reservation.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'global_keys.dart';
import 'screens/reservations_screen.dart'; 

void main() {
  runApp(const CoworkingApp());
}

class CoworkingApp extends StatelessWidget {
  const CoworkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coworking App',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFB88E2F, {
          50: Color(0xFFF5EDE0),
          100: Color(0xFFE8D3B3),
          200: Color(0xFFD9B680),
          300: Color(0xFFCA984D),
          400: Color(0xFFBF8233),
          500: Color(0xFFB88E2F),
          600: Color(0xFFB07E29),
          700: Color(0xFFA76B23),
          800: Color(0xFF9F591D),
          900: Color(0xFF8F3A12),
        }),
        colorScheme: ColorScheme.light(
          primary: Color(0xFFB88E2F), // Cor primária
          secondary: Color(0xFF6D4C41), // Cor secundária/accent
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/rooms': (context) => const RoomsScreen(),
        '/createReservation': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args != null) {
            return CreateReservationScreen(
              workspaceId: args['id'] as int,
              roomName: args['roomName'] as String,
              capacity: args['capacity'] as int,
            );
          }
          return const Scaffold(
            body: Center(child: Text('Erro: Dados do workspace não encontrados')),
          );
        },
        '/editReservation': (context) {
          // Tratamento seguro para argumentos
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Reservation) {
            return EditReservationScreen(reservation: args);
          }
          // Fallback para caso de erro
          return const Scaffold(
            body: Center(child: Text('Erro: Dados da reserva não encontrados')),
          );
        },
        '/reservationDetails': (context) {
          // Tratamento seguro para argumentos
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Reservation) {
            return ReservationDetailsScreen(reservation: args);
          }
          // Fallback para caso de erro
          return const Scaffold(
            body: Center(child: Text('Erro: Dados da reserva não encontrados')),
          );
        },
        '/profile': (context) => const ProfileScreen(),
        '/reservations': (context) => ReservationsScreen(key: reservationsScreenKey), // Adiciona a chave global
      },
    );
  }
}


