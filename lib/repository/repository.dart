import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> checkSession(String sessionToken) async {
    final Dio dio = Dio();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String sessionToken = prefs.getString('session') ?? "";

      Map fDataMap = {'session_token': sessionToken};
      FormData fData = FormData();

      fData.fields.addAll(fDataMap.entries.map((e) => MapEntry(e.key, e.value)));

      final response = await dio.post('https://client-server-nova.000webhostapp.com/session.php', data: fData);

      log("Check session: $response");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.data);

        return data['status'] == 'success';
      }
    } catch (e) {
      log(e.toString());
    }

    return false;
  }

  Future logout() async {
    final Dio dio = Dio();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String sessionToken = prefs.getString('session') ?? "";

      Map fDataMap = {'session_token': sessionToken};
      FormData fData = FormData();

      fData.fields.addAll(fDataMap.entries.map((e) => MapEntry(e.key, e.value)));

      final response = await dio.post('https://client-server-nova.000webhostapp.com/logout.php', data: fData);

      prefs.remove('session_token');
    } catch (e) {
      log(e.toString());
    }
  }

  Future login({required String username, required String password}) async {
    final Dio dio = Dio();

    Map fDataMap = {'user': username, 'pwd': password};
    FormData fData = FormData();

    fData.fields.addAll(fDataMap.entries.map((e) => MapEntry(e.key, e.value)));

    final response = await dio.post('https://client-server-nova.000webhostapp.com/login.php', data: fData);

    log("Response: $response");

    Map repoResponse = {'status': false, 'data': null};

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.data);

      if (data['status'] == 'success') {
        repoResponse['status'] = true;
        repoResponse['data'] = data;

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('session', data['session_token']);
      } else {
        repoResponse['data'] = data;
      }
    }

    return repoResponse;
  }
}
