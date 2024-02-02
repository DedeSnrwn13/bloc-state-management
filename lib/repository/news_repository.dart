import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';

class NewsRepository {
  final Dio dio = Dio();

  Future addNews({
    required String title,
    required String content,
    required String date,
    required File image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'judul': title,
        'deskripsi': content,
        'tanggal': date,
        'Url_image': await MultipartFile.fromFile(image.path, filename: 'image.jpg'),
      });

      Response response = await dio.post('https://clint-server-nova.000webhostapp.com/addnews.php', data: formData);

      log(response.data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future getNewsList(keyword) async {
    try {
      log("GETTING NEWS");

      var response = await dio.get(
        'https://client-server-nova.000webhostapp.com/listnews.php',
        queryParameters: {'key': keyword},
      );

      log("list $response");

      if (response.statusCode == 200) {
        List newsList = response.data;
        return newsList;
      } else {
        // Handle error cases if needed
        log('Error: ${response.statusCode}');

        return [];
      }
    } catch (e) {
      log('Dio Error: $e');

      return [];
    }
  }

  Future selectNews(String id) async {
    FormData formData = FormData.fromMap({
      'idnews': id,
    });

    final response = await dio.post(
      'https://client-server-nova.000webhostapp.com/selectdata.php',
      data: formData,
    );

    Map<String, dynamic> responseData = Map<String, dynamic>.from(response.data);

    log('Res $responseData');

    if (responseData['success'] == true) {
      responseData['data']['status'] == true;

      return responseData['data'];
    } else {
      return {
        'status': false,
        'msg': responseData['msg'],
      };
    }
  }

  Future deleteNews(String id) async {
    try {
      FormData formData = FormData.fromMap({
        'idnews': id,
      });

      final response = await dio.post(
        'https://client-server-nova.000webhostapp.com/deletebews.php',
        data: formData,
      );

      Map responseData = response.data;

      if (responseData['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> editNews({
    required String id,
    required String title,
    required String content,
    required String date,
    File? image,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        'idnews': id,
        'judul': title,
        'deskripsi': content,
        'tanggal': date,
      };

      if (image != null) {
        formDataMap['url_image'] = await MultipartFile.fromFile(image.path, filename: 'image.jpg');
      }

      FormData formData = FormData.fromMap(formDataMap);
      Response response = await dio.post(
        'https://client-server-nova.000webhostapp.com/editnews.php',
        data: formData,
      );

      log("RES ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
