import 'package:credit_card_project/models/user.dart';
import 'package:credit_card_project/services/cachingServices.dart';
import 'package:dio/dio.dart';
import 'server.dart';

final userDBServices = _UserDBServices();

class _UserDBServices {
  Future<User> myData({required String token}) async {
    final Response<Map> response = await dio.get('users/me',
        options: Options(
          headers: <String, dynamic>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token
          },
        ));
    if (response.statusCode == 200) {
      cachingServices.cacheUserData(response.data!);
      return User.fromMap(response.data!);
    } else {
      throw response.statusMessage ?? "error";
    }
  }

  Future<User> updateUserData({
    required String uid,
    required String jwt,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response<Map> response = await dio.put(
        "users/$uid",
        data: data,
        options: Options(
          headers: <String, dynamic>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': jwt
          },
        ),
      );
      if (response.statusCode == 200) {
        cachingServices.cacheUserData(response.data!);
        return User.fromMap(response.data!);
      }
      throw response.data ?? 'Server Error';
    } catch (e) {
      throw Exception("$e");
    }
  }
}
