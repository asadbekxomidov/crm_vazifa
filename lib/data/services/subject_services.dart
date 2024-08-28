import 'package:dio/dio.dart';
import 'package:vazifa/data/services/authentification_interseptor.dart'; // AuthInterceptor manzilini to'g'ri kiriting

class SubjectServices {
  final Dio dio;

  SubjectServices() : dio = Dio() {
    dio.interceptors.add(AuthInterceptor());
  }

  Future<void> addSubject(String name) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {"name": name};

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/subjects',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Subject added successfully');
      } else {
        print('Failed to add subject: ${response.statusCode}');
        throw 'Failed to add subject: ${response.statusCode}';
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error adding subject: $e');
      }
    }
  }

  Future<Map<String, dynamic>> getAllSubject() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/subjects',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data; 
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error fetching subjects: $e');
      }
      throw e;
    }
  }

  Future<void> getOneSubject(int subjectId) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/subjects/$subjectId',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error fetching subject: $e');
      }
    }
  }

  Future<void> editSubject(int subjectId, String name) async {
    try {
      final data = {"name": name};

      final response = await dio.put(
        'http://millima.flutterwithakmaljon.uz/api/subjects/$subjectId',
        data: data,
      );

      if (response.statusCode == 200) {
        print('Subject updated successfully');
      } else {
        print('Failed to update subject: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error updating subject: $e');
      }
    }
  }

  Future<void> deleteSubject(int subjectId) async {
    try {
      final response = await dio.delete(
        'http://millima.flutterwithakmaljon.uz/api/subjects/$subjectId',
      );

      if (response.statusCode == 200) {
        print('Subject deleted successfully');
      } else {
        print('Failed to delete subject: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error deleting subject: $e');
      }
    }
  }
}
