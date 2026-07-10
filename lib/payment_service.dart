import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
static const String baseUrl = 'http://10.238.134.139:3000';
  Future<String?> createPayment({
    required String email,
    required String firstName,
    required String lastName,
    required int amount,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-payment'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "amount": amount,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["redirect_url"];
    }

    throw Exception("Failed to create payment.");
  }
}