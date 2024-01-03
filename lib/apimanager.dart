import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiManager {
  final String baseUrl;
  final storage = FlutterSecureStorage();

  ApiManager({required this.baseUrl});

  Future<String?> authenticate(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['token'];

        await storage.write(key: 'auth_token', value: token);

        return token;
      } else {
        throw Exception('Failed to authenticate: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to authenticate: $e');
    }
  }

  Future<void> register(
      String name, String username, String password, String repassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'username': username,
          'password': password,
          'repassword': repassword
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to register: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<dynamic> createHotel(File image, String name, String description,
      String price, String location) async {
    final token = await storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('Token not found');
    }
    final uri = Uri.parse('$baseUrl/createHotel.php');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', image.path))
      ..fields['name'] = name
      ..fields['description'] = description
      ..fields['price'] = price
      ..fields['location'] = location
      ..headers['Content-Type'] = 'application/json'
      ..headers['Authorization'] = 'Bearer $token';

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(responseBody);
      return jsonResponse['message'];
    } else {
      return 'Failed to upload image. Status Code: ${response.statusCode}';
    }
  }

  Future<List<dynamic>> getHotels() async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/getHotels.php'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to get hotels. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get hotels: $e');
    }
  }

  Future<List<dynamic>> getHotelDashboard() async {
    try {
      var token = await storage.read(key: 'auth_token');
      var response = await http.get(
        Uri.parse('$baseUrl/getHotels.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to get hotels. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get hotels: $e');
    }
  }

  Future<String> updateHotel(String id, File? image, String name,
      String description, String price, String location) async {
    try {
      final uri = Uri.parse('$baseUrl/updateHotel.php');
      var token = await storage.read(key: 'auth_token');
      var request = http.MultipartRequest('POST', uri)
        ..fields['id'] = id
        ..fields['name'] = name
        ..fields['description'] = description
        ..fields['price'] = price
        ..fields['location'] = location
        ..headers['Content-Type'] = 'application/json'
        ..headers['Authorization'] = 'Bearer $token';
      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path!));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody);
        return jsonResponse['message'];
      } else {
        return 'Edit data hotel gagal. Status Code: ${response}';
      }
    } catch (e) {
      return 'Error uploading image: $e';
    }
  }

  Future<dynamic> deleteHotel(String id) async {
    try {
      final token = await storage.read(key: 'auth_token');

      if (token == null) {
        throw Exception('Token not found');
      }

      var response = await http.delete(
        Uri.parse('$baseUrl/deleteHotel.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to delete hotel. Status Code: ${response.statusCode}, Message: ${json.decode(response.body)['message']}');
      }
    } catch (e) {
      throw Exception('Failed to delete hotel: $e');
    }
  }
}
