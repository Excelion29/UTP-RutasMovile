import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iipvm/models/user.dart';

class AuthService with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  final _storage = const FlutterSecureStorage();

  AuthService(this.sharedPreferences);

  Future<void> login(String dni, String password) async {
    var url = dotenv.env['API_URL']! + '/api/v1/auth/login-carrier';
    final dio = Dio();
    final formData = FormData.fromMap({
      'dni': dni,
      'password': password,
    });

    try {   
      final response = await dio.post(url, data: formData);
      if (response.statusCode == 202) {
        final data = response.data['details'];
        await _storage.write(key: 'token', value: data['access_token']);
        // Save user data
        final user = User.fromJson(data); // Assuming your API response contains 'name' and 'dni'
        await saveUserData(user);

        notifyListeners();
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to send request');
    }
  }

  Future<void> saveUserData(User user) async {
    await _storage.write(key: 'user', value: json.encode(user.toJson()));
    sharedPreferences.setString('name', user.name);
    sharedPreferences.setString('dni', user.dni);
  }

  Future<User?> getUserData() async {
    final userData = await _storage.read(key: 'user');
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    }
    return null;
  }

 Future<void> logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user');
    sharedPreferences.remove('name');
    sharedPreferences.remove('dni');

    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    String? token = await _storage.read(key: 'token');
    return token != null;
  }

}
