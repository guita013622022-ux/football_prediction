import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_payments_page.dart';
import 'admin_page.dart';
import 'free_predictions_page.dart';
import 'vip_predictions_page.dart';
import 'results_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'vip_page.dart';
import 'vip_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkAdmin();
  }
Future<void> openVipPage(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return;
  }

  bool isVip = await VipChecker().isVipActive(user.uid);

  if (context.mounted) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            isVip ? const VipPredictionsPage() : const VipPage(),
      ),
    );
  }
}
  Future<void> checkAdmin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      setState(() {
        isAdmin = doc.data()?['isAdmin'] ?? false;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required Widget page,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.8),
              color,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: color,
                size: 35,
              ),
            ),
            const SizedBox(width: 25),
           Expanded(
  child: Text(
    title,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000428),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Football Prediction'),
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminPage(),
                  ),
                );
              },
            ),

          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          const Center(
            child: Text(
              'Welcome Back!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Center(
            child: Text(
              'Win with Smart Predictions',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 22,
              ),
            ),
          ),

          const SizedBox(height: 20),

          buildCard(
            icon: Icons.sports_soccer,
            title: 'Free Daily Predictions',
            page: const FreePredictionsPage(),
            color: Colors.blue,
          ),

          buildCard(
            icon: Icons.star,
            title: 'VIP Predictions',
            page: const VipPage(),
            color: Colors.orange,
          ),

          buildCard(
            icon: Icons.emoji_events,
            title: 'Results',
            page: const ResultsPage(),
            color: Colors.green,
          ),
          if (isAdmin)
  buildCard(
    icon: Icons.payments,
    title: 'Payment Requests',
    page: const AdminPaymentsPage(),
    color: Colors.purple,
  ),
        ],
      ),
    );
  }
}