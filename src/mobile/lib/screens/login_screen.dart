
import 'package:coworking_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = FlutterSecureStorage();
  bool _isLoading = false;

  // Validação de email usando regex
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await AuthService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result != false) {      
      // Checagem de mounted novamente, antes de navegar
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no login. Verifique suas credenciais'),
          backgroundColor: Colors.red,
        ),
      );
    }

    print(
      'Tentando login com: ${_emailController.text}, ${_passwordController.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    final ButtonStyle? buttonStyle = theme.elevatedButtonTheme.style;
    final TextStyle? buttonTextStyle = buttonStyle?.textStyle?.resolve({});

    return Scaffold(
      
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400), 
              child: Card(
                elevation: 4,
                color: AppColors.white, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        Image.asset(
                          'assets/images/logo_png_belospace.png',
                          height: 60, 
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Bem-vindo(a)!',
                          style: textTheme.headlineSmall?.copyWith(color: AppColors.textDark),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Entre com seu usuário e senha para acessar o sistema',
                          style: textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Usuário', 
                            
                            
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu email';
                            }
                            if (!_isValidEmail(value)) {
                              return 'Por favor, insira um email válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            
                            
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            
                            
                            
                            
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              
                            },
                            child: Text(
                              'Esqueceu sua senha?',
                              style: textTheme.bodySmall?.copyWith(color: AppColors.textGrey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24, 
                                    width: 24,
                                    child: CircularProgressIndicator(strokeWidth: 3, color: AppColors.white),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      
                                      Text('Login', style: buttonTextStyle),
                                      const SizedBox(width: 8),
                                      
                                      Icon(Icons.arrow_forward, size: 20, color: buttonTextStyle?.color),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ainda não é cliente? ',
                              style: textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
                            ),
                            TextButton(
                              style: theme.textButtonTheme.style?.copyWith(
                                padding: MaterialStateProperty.all(EdgeInsets.zero), 
                                minimumSize: MaterialStateProperty.all(Size.zero), 
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, 
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Cadastre-se aqui',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primaryOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
