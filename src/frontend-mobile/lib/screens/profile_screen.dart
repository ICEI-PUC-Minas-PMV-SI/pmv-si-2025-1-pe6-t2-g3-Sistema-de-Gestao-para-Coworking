import 'dart:convert';

import 'package:coworking_app/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:coworking_app/components/header.dart';
import 'package:intl/intl.dart';
import 'login_screen.dart'; // Para o logout
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import 'package:coworking_app/utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _storage = FlutterSecureStorage();
  User? _user;
  final DateFormat _displayDateFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

Future<void> _loadUser() async {
  final jsonStr = await _storage.read(key: 'user_data');
  debugPrint('Dados brutos do usuário: $jsonStr'); // Adicione esta linha

  if (jsonStr != null && jsonStr.isNotEmpty) {
    try {
      final userData = jsonDecode(jsonStr) as Map<String, dynamic>;
      if (userData.isNotEmpty) {
        setState(() {
          _user = User.fromJson(userData);
        });
      }
    } catch (e) {
      debugPrint('Error parsing user data: $e');
    }
  } else {
    debugPrint('No user data found in storage');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: "Meu Perfil", showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfilePicture(),
            const SizedBox(height: 20),
            if (_user != null) _buildUserInfoCard(context) else const CircularProgressIndicator(),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: const Color(0xFFB88E2F).withOpacity(0.2),
      child: const Icon(Icons.person, size: 60, color: Color(0xFFB88E2F)),
    );
  }

  Widget _buildUserInfoCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(Icons.person, "Nome", _user!.username),
            const Divider(),
            _buildInfoRow(Icons.email, "E-mail", _user!.email),
            const Divider(),
            _buildInfoRow(Icons.date_range, "Membro desde", "Jun 2025"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textDark),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: AppColors.textDark),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => _showLogoutConfirmation(context),
        child: const Text("SAIR DA CONTA"),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sair da conta"),
        content: const Text("Tem certeza que deseja sair da sua conta?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await _storage.delete(key: 'user_data');
              if (!mounted) return;
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text("Sair", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}