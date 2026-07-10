import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPaymentsPage extends StatelessWidget {
  const AdminPaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payment_requests')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text('No payment requests'),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
             final doc = docs[index];
final map = doc.data() as Map<String, dynamic>;

return Card(
  child: ListTile(
    title: Text(map['name'] ?? 'No Name'),
    subtitle: Text(
      '${map['phone'] ?? 'No Phone'}\nUGX ${map['amount'] ?? 0}',
    ),
    trailing: Text(map['status'] ?? 'pending'),
  ),
);
            },
          );
        },
      ),
    );
  }
}