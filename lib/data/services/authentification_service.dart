import 'package:dio/dio.dart';
import 'package:vazifa/data/models/authentification_response.dart';
import 'package:vazifa/data/models/social_login_model.dart';
import 'package:vazifa/data/services/authentification_interseptor.dart';

class AuthentificationService {
  final Dio dio;

  AuthentificationService() : dio = Dio() {
    dio.interceptors.add(AuthInterceptor());
  }

  Future register(String name, String phoneNumber, int roleId, String password,
      String passwordConfirmation) async {
    try {
      final response = await dio
          .post("http://millima.flutterwithakmaljon.uz/api/register", data: {
        'name': name,
        'phone': phoneNumber,
        'role_id': roleId,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      return response.data;
    } on DioException catch (error) {
      return error.response!.data.toString();
    } catch (e) {
      print(e.toString());
    }
  }

  Future login(String phoneNumber, String password) async {
    try {
      final response = await dio
          .post("http://millima.flutterwithakmaljon.uz/api/login", data: {
        'phone': phoneNumber,
        'password': password,
      });

      return response.data;
    } on DioException catch (error) {
      return error.response!.data.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> logout() async {
    try {
      final response = await dio.post(
        "http://millima.flutterwithakmaljon.uz/api/logout",
      );

      print(response);

      if (response.data['success'] == true) {
        return "success";
      }
      return "Failed to Log Out";
    } catch (e) {
      rethrow;
    }
  }

  Future socialRegisterGoogle(String email, String displayname) async {
    try {
      final response = await dio
          .post("http://millima.flutterwithakmaljon.uz/api/login", data: {
        'name': displayname,
        'email': email,
      });
      print(response.data.toString());

      return response.data;
    } on DioException catch (error) {
      return error.response!.data.toString();
    } catch (e) {
      rethrow;
    }
  }

    Future<AuthenticationResponse> socialLogin(SocialLoginRequest request) async {
    try {
      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/social-login',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

}
