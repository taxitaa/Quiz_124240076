import 'package:flutter/material.dart';
import 'package:kuis/pages/dashboard.dart';

const Color _sand = Color(0xFFF3E6D5);
const Color _wine = Color(0xFF800020);
const Color _coral = Color(0xFFD45060);
const Color _paper = Color(0xFFFFF9F2);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if (username == 'mitajannah' && password == '076') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const DashboardPage()),
      );
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Username atau password tidak sesuai.'),
          backgroundColor: _wine,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: _wine),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: _paper,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _sand),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _sand),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _wine, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _sand,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: _paper,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: _wine.withValues(alpha: 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            color: _wine,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu_rounded,
                            color: _paper,
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Culinarizz',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _wine,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Informasi berbagai makanan khas Indonesia',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: _inputDecoration(
                          label: 'Username',
                          icon: Icons.person,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Username wajib diisi.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _login(),
                        decoration: _inputDecoration(
                          label: 'Password',
                          icon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            tooltip: _obscurePassword
                                ? 'Tampilkan password'
                                : 'Sembunyikan password',
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: _wine,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        height: 52,
                        child: FilledButton(
                          onPressed: _login,
                          style: FilledButton.styleFrom(
                            backgroundColor: _coral,
                            foregroundColor: _paper,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
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
