import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.rekalaba.com/public/transaction/queue';

  Future<Map<String, dynamic>> getQueueList({String phoneNumber = ''}) async {
    final response = await http
        .get(Uri.parse('$baseUrl/stores/16880?phone-number=$phoneNumber'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load queue data');
    }
  }

  Future<Map<String, dynamic>> submitQueue(
      String name, String phone, int pax) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'storeId': 16880,
        'customerName': name,
        'customerPhone': phone,
        'pax': pax,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit queue');
    }
  }
}
