/// DO NOT USE IN UI
import 'package:credit_card_project/models/user.dart';
import 'package:credit_card_project/services/server.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class _LoginResponse {
  final User data;
  final Map<String, dynamic> tokens;
  _LoginResponse({required this.data, required this.tokens});
}

///⚠ ⚠ DO NOT USE IN UI ⚠ ⚠
final authRepository = _AuthRepository();

class _AuthRepository {
  Future<_LoginResponse> signup(
      {required String email,
      required String password,
      required String displayName}) async {
    try {
      Response<Map> response = await dio.post(
        "/auth/register",
        data: {
          "name": displayName,
          "email": email,
          "password": password,
        },
        options: Options(headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      if (response.statusCode == 200) {
        debugPrint('signedup');
        final Map map = response.data!;
        final me = User.fromMap(map['user'] as Map);
        return _LoginResponse(data: me, tokens: map['tokens']);
      } else {
        debugPrint('SIGNUP ERROR ${response.data}');
        throw "Sorry, could not sign you up at the moment, please try again later.";
      }
    } catch (e) {
      if (e is DioError) print(e.response?.data ?? "");
      throw e is String
          ? e
          : "Sorry, could not sign you up at the moment, please try again later.";
    }
  }

  Future<bool> resendVerification({required String email}) async {
    try {
      final response = await dio.post(
        "auth/send-verification-email",
        data: {
          'email': email,
        },
        options: Options(headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('verification mail sent');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      final response = await dio.post("auth/forgot-password", data: {
        'email': email,
      });
      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
    return false;
  }

  Future logout({required String jwt, required String refreshToken}) async {
    try {
      await dio.post("auth/logout",
          data: {"refreshToken": "Bearer $refreshToken"},
          options: Options(headers: {"Authorization": jwt}));
    } catch (e) {
      if (e is DioError)
        print(e.response.toString());
      else
        print(e);
      throw e is String
          ? e
          : "Sorry, could not log you out at the moment, please try again later.";
    }
  }

  Future<_LoginResponse> login(
      {required String username, required String password}) async {
    try {
      final Response<Map> response = await dio.post(
        "auth/login",
        data: {
          'email': username,
          'password': password,
        },
        options: Options(headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final Map map = response.data!;
        final me = User.fromMap(map['user'] as Map);
        return _LoginResponse(data: me, tokens: map['tokens']);
      } else {
        throw "Sorry, could not log you in at the moment, please try again later.";
      }
    } catch (e) {
      print(e.toString());
      if (e is DioError) {
        final error = e;
        if (error.response?.data?["data"][0]["messages"][0]["id"] ==
            "Auth.form.error.invalid") {
          throw "Sorry, could not log you in, the email id or password is incorrect.";
        } else if (error.response?.data?["data"][0]["messages"][0]["id"] ==
            "Auth.form.error.confirmed") {
          throw "Sorry, could not log you in, the email id is not verified yet. Please check your inbox and verify your email id.";
        } else {
          debugPrint(' login error ${e.message}');
          throw "Sorry, could not log you in at the moment, please try again later.";
        }
      } else if (e is String) {
        rethrow;
      } else {
        throw e.toString();
      }
    }
  }
}
