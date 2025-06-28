import 'package:flutter/material.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:flutter_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                final authService = AuthService();
                final success = await authService.login(
                  _usernameController.text,
                  _passwordController.text,
                );
                if (success) {
                  // Navigate to home screen or dashboard
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Successful!')),
                  );
                  // TODO: Navigate to the main app screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Failed. Please check your credentials.')),
                  );
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Don\'t have an account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}
