import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> activateSubscription({
    required String userId,
    required String plan,
    required String paymentMethod,
    required String paymentReference,
  }) async {
    DateTime startDate = DateTime.now();
    DateTime expiryDate;
    switch (plan) {
      case "Weekly":
        expiryDate = startDate.add(const Duration(days: 7));
        break;

      case "Monthly":
        expiryDate = startDate.add(const Duration(days: 30));
        break;

      case "Yearly":
        expiryDate = startDate.add(const Duration(days: 365));
        break;

      default:
        expiryDate = startDate;
    }

    await _firestore.collection("users").doc(userId).set({
      "vip": true,
      "plan": plan,
      "paymentStatus": "Paid",
      "paymentMethod": paymentMethod,
      "paymentReference": paymentReference,
      "startDate": Timestamp.fromDate(startDate),
      "expiryDate": Timestamp.fromDate(expiryDate),
    }, SetOptions(merge: true));
  }
}