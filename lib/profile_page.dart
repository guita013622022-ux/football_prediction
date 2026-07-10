import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }

          final data =
              snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [

                const SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(.4),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),

                  child: const CircleAvatar(
                    radius: 65,
                    backgroundColor: Color(0xFF1F2937),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 75,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  data['name'] ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  data['isVip'] == true
                      ? "⭐ VIP Member"
                      : "⚽ Free Member",
                  style: TextStyle(
                    color: data['isVip'] == true
                        ? Colors.amber
                        : Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 35),
                Card(
                  color: const Color(0xFF1E293B),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    leading: const Icon(
                      Icons.email,
                      color: Colors.green,
                      size: 32,
                    ),
                    title: const Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data['email'] ?? "",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Card(
                  color: const Color(0xFF1E293B),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 32,
                    ),
                    title: const Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data['phone'] ?? "",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Card(
                  color: const Color(0xFF1E293B),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    leading: Icon(
                      data['isVip'] == true
                          ? Icons.workspace_premium
                          : Icons.star_border,
                      color: data['isVip'] == true
                          ? Colors.amber
                          : Colors.green,
                      size: 32,
                    ),
                    title: const Text(
                      "Membership",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data['isVip'] == true
                          ? "VIP Member"
                          : "Free Member",
                      style: TextStyle(
                        color: data['isVip'] == true
                            ? Colors.amber
                            : Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                const Divider(
                  color: Colors.white24,
                ),

                const SizedBox(height: 15),

                const Text(
                  "⚽ Football Prediction",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Version 1.0",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          );
        },
      ),
    );
  }
}