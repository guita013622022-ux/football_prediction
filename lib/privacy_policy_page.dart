import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(
            '''
Football Prediction App Privacy Policy

1. We collect your email address for login purposes.

2. We do not sell your personal information.

3. Predictions and subscription information are stored securely.

4. Users are responsible for their accounts.

5. By using this app, you agree to our terms and conditions.
            ''',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}