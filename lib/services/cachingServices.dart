import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final cachingServices = _CachingServices();

class _CachingServices {
  final _userDataKey = "cache_data_userData";
  Future cacheUserData(Map data) async {
    final s = await SharedPreferences.getInstance();
    final String ts = json.encode(data);
    s.setString(_userDataKey, ts);
  }

  Future clearCacheUserData() async {
    final s = await SharedPreferences.getInstance();
    s.setString(_userDataKey, "");
  }

  Future<Map> getCachedUserData() async {
    final s = await SharedPreferences.getInstance();
    final res = s.getString(_userDataKey);
    if (res == null || res == "") {
      throw Exception("No Cached Data Found");
    } else {
      debugPrint("cached data found");
      return json.decode(res) as Map;
    }
  }
}
