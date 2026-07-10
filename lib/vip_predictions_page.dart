import 'package:flutter/material.dart';

class VipPredictionsPage extends StatefulWidget {
  const VipPredictionsPage({super.key});

  @override
  State<VipPredictionsPage> createState() => _VipPredictionsPageState();
}

class _VipPredictionsPageState extends State<VipPredictionsPage> {

  String selectedPlan = "Monthly";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08131F),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "VIP Membership",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 10),

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.workspace_premium,
                color: Colors.amber,
                size: 70,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Unlock Premium Football Predictions",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Get access to daily VIP predictions, correct scores, jackpot tips and much more.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 35),
            _buildPlanCard(
              title: "Weekly VIP",
              price: "\$4",
              duration: "7 Days Access",
              color: Colors.green,
              badge: "",
              selected: selectedPlan == "Weekly",
              onTap: () {
                setState(() {
                  selectedPlan = "Weekly";
                });
              },
            ),

            const SizedBox(height: 20),

            _buildPlanCard(
              title: "Monthly VIP",
              price: "\$10",
              duration: "30 Days Access",
              color: Colors.amber,
              badge: "MOST POPULAR",
              selected: selectedPlan == "Monthly",
              onTap: () {
                setState(() {
                  selectedPlan = "Monthly";
                });
              },
            ),

            const SizedBox(height: 20),

            _buildPlanCard(
              title: "Yearly VIP",
              price: "\$90",
              duration: "365 Days Access",
              color: Colors.orange,
              badge: "BEST VALUE",
              selected: selectedPlan == "Yearly",
              onTap: () {
                setState(() {
                  selectedPlan = "Yearly";
                });
              },
            ),

            const SizedBox(height: 35),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "VIP Benefits",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildBenefit(Icons.check_circle, "Daily VIP Predictions"),
            _buildBenefit(Icons.check_circle, "Correct Score Tips"),
            _buildBenefit(Icons.check_circle, "Over/Under Predictions"),
            _buildBenefit(Icons.check_circle, "HT/FT Predictions"),
            _buildBenefit(Icons.check_circle, "Jackpot Analysis"),

            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2432),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.lock,
                    color: Colors.green,
                    size: 45,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Secure Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Your payment will be processed securely by Pesapal.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      Chip(
                        avatar: Icon(Icons.phone_android),
                        label: Text("MTN MoMo"),
                      ),
                      Chip(
                        avatar: Icon(Icons.phone_android),
                        label: Text("Airtel Money"),
                      ),
                      Chip(
                        avatar: Icon(Icons.credit_card),
                        label: Text("Visa"),
                      ),
                      Chip(
                        avatar: Icon(Icons.credit_card),
                        label: Text("Mastercard"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Pesapal payment for $selectedPlan plan will be connected soon.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.lock),
                      label: Text(
                        "Pay for $selectedPlan",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Powered by Pesapal",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildPlanCard({
  required String title,
  required String price,
  required String duration,
  required Color color,
  required String badge,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected ? color.withOpacity(.2) : const Color(0xFF1B2432),
        border: Border.all(
          color: selected ? color : Colors.white24,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          if (badge.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          if (badge.isNotEmpty)
            const SizedBox(height: 15),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            price,
            style: TextStyle(
              color: color,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            duration,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBenefit(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ],
    ),
  );
}}