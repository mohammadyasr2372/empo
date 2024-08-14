import 'dart:convert';

import 'package:dio/dio.dart';

abstract class IDD {
  Future<int> addNumber(String num1, String num2);
}

class UIDD implements IDD {
  @override
  Future<int> addNumber(String num1, String num2) async {
    final String url = 'http://10.0.2.2:8001/numbers/add/';
    Dio dio = Dio();
    Map<String, dynamic> data = {
      'num1': num1,
      'num2': num2,
    };
    print('Sending data: $data'); // Add print statement to verify data
    try {
      final response = await dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        // Assuming the response contains the new ID
        final newDeviceId = response.data['id'];
        print('Numbers added successfully with ID: $newDeviceId');
        return newDeviceId; // Return the new device ID
      } else {
        throw Exception('Failed to add numbers');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.message}');
        if (e.response != null) {
          print('DioError Response data: ${e.response?.data}');
          print('DioError Response headers: ${e.response?.headers}');
          print('DioError Response status code: ${e.response?.statusCode}');
        }
      } else {
        print('Error: $e');
      }
      throw Exception('Failed to add numbers');
    }
  }
}

class ID {
  final IDD idd;

  ID(this.idd);

  Future<int> addNumber(String num1, String num2) async {
    return idd.addNumber(num1, num2);
  }
}
