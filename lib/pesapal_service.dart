import 'dart:convert';
import 'package:http/http.dart' as http;

class PesapalService {
  // Replace these with your real Pesapal credentials
  static const String consumerKey = "YOUR_CONSUMER_KEY";
  static const String consumerSecret = "YOUR_CONSUMER_SECRET";

  static const String baseUrl = "https://pay.pesapal.com/v3/api";

  Future<String?> getAccessToken() async {
    final response = await http.post(
      Uri.parse("$baseUrl/Auth/RequestToken"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "consumer_key": consumerKey,
        "consumer_secret": consumerSecret,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["token"];
    }

    return null;
  }
}