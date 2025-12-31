import 'user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-api-key':
            'reqres_bbca121c38f748198e21e44314b34e2b', // ✅ WAJIB BERISI API KEY
      },
    ),
  );
  Future getUsers() async {
    try {
      final res = await dio.get('/users');

      debugPrint('STATUS: ${res.statusCode}');
      debugPrint('DATA: ${res.data}');

      return res.data;
    } catch (e) {
      debugPrint("ERROR: $e");
      return null;
    }
  }

  Future<UserCreate?> postUser(UserCreate user) async {
    try {
      final response = await dio.post('/users', data: user.toMap());

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('DATA: ${response.data}');

      // Cek apakah status code menunjukkan bahwa resource berhasil dibuat
      if (response.statusCode == 201) {
        return UserCreate.fromJson(response.data);
      }

      return null;
    } on DioException catch (e) {
      // Melihat detail error dari response
      debugPrint("DIO ERROR STATUS: ${e.response?.statusCode}");
      debugPrint("DIO ERROR DATA: ${e.response?.data}");
      return null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return null;
    }
  }

  Future putUser(String idUser, String name, String job) async {
    try {
      final response = await dio.put(
        '/users/$idUser',
        data: {'name': name, 'job': job},
      );
      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('DATA: ${response.data}');

      // Cek apakah status code menunjukkan bahwa resource berhasil dibuat
      if (response.statusCode == 200) {
        return UserCreate.fromJson(response.data);
      }
    } on DioException catch (e) {
      // Melihat detail error dari response
      debugPrint("DIO ERROR STATUS: ${e.response?.statusCode}");
      debugPrint("DIO ERROR DATA: ${e.response?.data}");
      return null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return null;
    }
  }

  Future deleteUser(String idUser) async {
    try {
      final response = await dio.delete('/users/$idUser');

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('DATA: ${response.data}');

      // Cek apakah status code menunjukkan bahwa resource berhasil dihapus
      if (response.statusCode == 204) {
        return 'User deleted successfully';
      }

      return null;
    } on DioException catch (e) {
      // Melihat detail error dari response
      debugPrint("DIO ERROR STATUS: ${e.response?.statusCode}");
      debugPrint("DIO ERROR DATA: ${e.response?.data}");
      return null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return null;
    }
  }

  Future<Iterable<User>?> getUserModel() async {
    try {
      var response = await dio.get('/users');
      if (response.statusCode == 200) {
        final users = (response.data['data'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();
        return users;
      }
    } catch (e) {
      rethrow;
    }
  }
}
