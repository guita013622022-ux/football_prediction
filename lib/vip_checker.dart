import 'package:cloud_firestore/cloud_firestore.dart';

class VipChecker {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isVipActive(String userId) async {
    final doc =
        await _firestore.collection('users').doc(userId).get();

    if (!doc.exists) return false;

    final data = doc.data();

    if (data == null) return false;

    if (data['vip'] != true) return false;

    Timestamp expiryTimestamp = data['expiryDate'];

    DateTime expiryDate = expiryTimestamp.toDate();

    if (DateTime.now().isAfter(expiryDate)) {
      await _firestore.collection('users').doc(userId).update({
        'vip': false,
        'paymentStatus': 'Expired',
      });

      return false;
    }

    return true;
  }
}