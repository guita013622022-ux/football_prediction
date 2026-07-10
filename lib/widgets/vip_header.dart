import 'package:flutter/material.dart';

class VipHeader extends StatelessWidget {
  const VipHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B6E4F),
            Color(0xFF1B4332),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.workspace_premium,
              size: 45,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 18),

          Text(
            "VIP MEMBERSHIP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Unlock Premium Football Predictions",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}