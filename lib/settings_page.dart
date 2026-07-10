       import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'privacy_policy_page.dart';
import 'package:url_launcher/url_launcher.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
Future<void> _contactUs() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'footballprediction72@gmail.com',
    queryParameters: {
      'subject': 'Football Prediction Support',
    },
  );

  if (!await launchUrl(
    emailUri,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch email app');
  }
}

  
  Future<void> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.delete();

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Unable to delete account. Please log in again.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [

          const SizedBox(height: 20),

          const CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.person,
              size: 45,
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: Text(
              user?.email ?? "User",
              style: const TextStyle(fontSize: 18),
            ),
          ),

          const SizedBox(height: 30),

          SwitchListTile(
            title: const Text("Notifications"),
            subtitle: const Text(
              "Receive prediction updates",
            ),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),

          const Divider(),

         ListTile(
  leading: const Icon(Icons.email),
  title: const Text("Contact Us"),
  subtitle: const Text("footballprediction72@gmail.com"),
  onTap: _contactUs,
),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy Policy"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const PrivacyPolicyPage(),
                ),
              );
            },
          ),

          const Divider(), 

         const ListTile(
            leading: Icon(Icons.info),
            title: Text("Version"),
            subtitle: Text("1.0.0"),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            title: const Text(
              "Delete Account",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Account"),
                  content: const Text(
                    "Are you sure you want to permanently delete your account?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await deleteAccount();
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () async {
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
    );
  }
}