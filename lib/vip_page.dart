import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'payment_service.dart';
import 'widgets/vip_header.dart';
import 'widgets/plan_card.dart';
import 'widgets/payment_card.dart';
import 'widgets/subscribe_button.dart';
import 'subscription_service.dart';
import 'payment_success_page.dart';

class VipPage extends StatefulWidget {
  const VipPage({super.key});

  @override
  State<VipPage> createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  final PaymentService paymentService = PaymentService();
final SubscriptionService subscriptionService = SubscriptionService();

  String selectedPlan = "Monthly";
  String selectedPayment = "MTN Mobile Money";

  bool isLoading = false;

  int getAmount() {
    switch (selectedPlan) {
      case "Weekly":
        return 5;
      case "Yearly":
        return 99;
      default:
        return 15;
    }
  }

  Future<void> makePayment() async {
    setState(() {
      isLoading = true;
    });

    try {
      final paymentUrl = await paymentService.createPayment(
        email: "vip@footballprediction.com",
        firstName: "VIP",
        lastName: "Member",
        amount: getAmount(),
      );

      if (paymentUrl != null) {
  final uri = Uri.parse(paymentUrl);

 if (await canLaunchUrl(uri)) {
  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );

  // Activate VIP subscription
  await subscriptionService.activateSubscription(
    userId: "demo_user",
    plan: selectedPlan,
    paymentMethod: selectedPayment,
    paymentReference: "PESAPAL_DEMO_001",
  );

  if (!mounted) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => PaymentSuccessPage(plan: selectedPlan),
    ),
  );
}}

    // Activate VIP subscription
   
    } catch (e) {
     print("PAYMENT ERROR: $e");

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("Payment Error: $e"),
  ),
);

setState(() {
  isLoading = false;
});
  }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const VipHeader(),

              const SizedBox(height: 30),

Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            Icons.workspace_premium,
            color: Colors.amber,
            size: 30,
          ),
          SizedBox(width: 10),
          Text(
            "VIP Benefits",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      SizedBox(height: 18),

      Text("✅ Daily VIP Predictions"),
      SizedBox(height: 10),

      Text("✅ Correct Score Tips"),
      SizedBox(height: 10),

      Text("✅ 90%+ Accuracy Picks"),
      SizedBox(height: 10),

      Text("✅ Over/Under Predictions"),
      SizedBox(height: 10),

      Text("✅ BTTS Predictions"),
      SizedBox(height: 10),

      Text("✅ Early Match Access"),
      SizedBox(height: 10),

      Text("✅ Premium Customer Support"),
    ],
  ),
),

const SizedBox(height: 30),

              const Text(
                "Choose Your Plan",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              PlanCard(
                title: "Weekly",
                subtitle: "Perfect for trying VIP",
                price: "\$5 / Week",
                selected: selectedPlan == "Weekly",
                onTap: () {
                  setState(() {
                    selectedPlan = "Weekly";
                  });
                },
              ),

              PlanCard(
                title: "Monthly",
                subtitle: "⭐ Most Popular",
                price: "\$15 / Month",
                selected: selectedPlan == "Monthly",
                onTap: () {
                  setState(() {
                    selectedPlan = "Monthly";
                  });
                },
              ),

              PlanCard(
                title: "Yearly",
                subtitle: "👑 Best Value",
                price: "\$99 / Year",
                selected: selectedPlan == "Yearly",
                onTap: () {
                  setState(() {
                    selectedPlan = "Yearly";
                  });
                },
              ),

              const SizedBox(height: 30),

              const Text(
                "Choose Payment Method",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              PaymentCard(
                title: "MTN Mobile Money",
                subtitle: "Fast and secure mobile payments",
                icon: Icons.phone_android,
                color: Colors.amber,
                selected: selectedPayment == "MTN Mobile Money",
                onTap: () {
                  setState(() {
                    selectedPayment = "MTN Mobile Money";
                  });
                },
              ),

              PaymentCard(
                title: "Airtel Money",
                subtitle: "Pay securely with Airtel",
                icon: Icons.phone_android,
                color: Colors.red,
                selected: selectedPayment == "Airtel Money",
                onTap: () {
                  setState(() {
                    selectedPayment = "Airtel Money";
                  });
                },
              ),

              PaymentCard(
                title: "Visa / Mastercard",
                subtitle: "Debit & Credit Cards",
                icon: Icons.credit_card,
                color: Colors.blue,
                selected: selectedPayment == "Visa / Mastercard",
                onTap: () {
                  setState(() {
                    selectedPayment = "Visa / Mastercard";
                  });
                },
              ),

              const SizedBox(height: 30),

              SubscribeButton(
                loading: isLoading,
                amount: getAmount(),
                onPressed: makePayment,
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  "🔒 Payments secured by Pesapal",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "Your payment information is protected and processed securely.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}