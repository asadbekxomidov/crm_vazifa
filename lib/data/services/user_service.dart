import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vazifa/data/services/authentification_interseptor.dart';

class UserService {
  final Dio dio;

  UserService() : dio = Dio() {
    dio.interceptors.add(AuthInterceptor());
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/user',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      ;

      print(
          '----------------Get User-----------------------------------${response.data.toString()}-----------------------------------------');
      return response.data;
    } on DioException catch (error) {
      throw error.response!.data.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUsers() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/users',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      print(
          '----------------Get Userssssssssssss-----------------------------------${response.data.toString()}-----------------------------------------');

      return response.data;
    } on DioException catch (error) {
      print(error.response!.data);
      throw error.response!.data.toString();
    } catch (e) {
      rethrow;
    }
  }

  // Future<Map<String, dynamic>> getUsers() async {
  //   try {
  //     final response = await dio.get(
  //       'http://millima.flutterwithakmaljon.uz/api/users',
  //     );

  //     if (response.data['success'] == false) {
  //       throw response.data;
  //     }

  //     return response.data;
  //   } on DioException catch (error) {
  //     print(error.response!.data);
  //     throw error.response!.data.toString();

  //     // throw error.message.toString();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> updateProfile({
    required String name,
    String? email,
    required String phone,
    File? photo,
  }) async {
    try {
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('name', name),
        MapEntry('phone', phone),
      ]);

      if (email != null) {
        formData.fields.add(MapEntry('email', email));
      }

      if (photo != null) {
        formData.files.add(
          MapEntry(
            'photo',
            await MultipartFile.fromFile(
              photo.path,
              filename: 'profile_photo.${photo.path.split('.').last}',
            ),
          ),
        );
      }

      final response = await dio.post(
        "http://millima.flutterwithakmaljon.uz/api/profile/update",
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      print("Profile updated: ${response.data}");
    } on DioException catch (error) {
      print("Failed to update profile: ${error.response?.data}");
      // throw error.message.toString();
      throw error.response!.data.toString();
    } catch (e) {
      print("An error occurred: $e");
      rethrow;
    }
  }
}
