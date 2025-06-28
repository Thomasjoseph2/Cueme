import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String _baseUrl = 'http://localhost:3000/api/auth'; // Replace with your backend URL
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      await _storage.write(key: 'jwt', value: data['token']);
      return true;
    } else {
      // Handle login error (e.g., show a snackbar)
      print('Login failed: ${response.body}');
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) { // Assuming 201 for successful creation
      return true;
    } else {
      // Handle registration error
      print('Registration failed: ${response.body}');
      return false;
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt');
  }
}