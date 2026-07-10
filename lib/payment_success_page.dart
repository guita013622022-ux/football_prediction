import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String plan;

  const PaymentSuccessPage({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    size: 65,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Payment Successful!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "Welcome to the $plan VIP Membership",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 30),

                const Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: Colors.green),
                          title: Text("VIP Predictions"),
                        ),
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: Colors.green),
                          title: Text("Correct Score Tips"),
                        ),
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: Colors.green),
                          title: Text("Over/Under Predictions"),
                        ),
                        ListTile(
                          leading: Icon(Icons.check_circle,
                              color: Colors.green),
                          title: Text("BTTS Predictions"),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text(
                      "Go to VIP Predictions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}