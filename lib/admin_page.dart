import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController matchController =
      TextEditingController();

  final TextEditingController predictionController =
      TextEditingController();

  final TextEditingController resultController =
      TextEditingController();

  // ADD FREE PREDICTION
  Future<void> addPrediction() async {
    await FirebaseFirestore.instance
        .collection('free_predictions')
        .add({
      'match': matchController.text,
      'prediction': predictionController.text,
      'date': DateTime.now(),
    });

    matchController.clear();
    predictionController.clear();
  }

  // ADD VIP PREDICTION
  Future<void> addVipPrediction() async {
    await FirebaseFirestore.instance
        .collection('vip_predictions')
        .add({
      'match': matchController.text,
      'prediction': predictionController.text,
      'date': DateTime.now(),
    });

    matchController.clear();
    predictionController.clear();
  }

  // ADD RESULT
  Future<void> addResult() async {
  await FirebaseFirestore.instance
      .collection('results')
      .add({
    'match': matchController.text,
    'result': resultController.text,
    'date': DateTime.now(),
  });

  matchController.clear();
  resultController.clear();
}

  // DELETE FREE PREDICTION
  Future<void> _deletePrediction(String id) async {
    await FirebaseFirestore.instance
        .collection('free_predictions')
        .doc(id)
        .delete();
  }

  // DELETE VIP PREDICTION
  Future<void> _deleteVipPrediction(String id) async {
    await FirebaseFirestore.instance
        .collection('vip_predictions')
        .doc(id)
        .delete();
  }

  // DELETE RESULT
  Future<void> _deleteResult(String id) async {
    await FirebaseFirestore.instance
        .collection('results')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: matchController,
              decoration: const InputDecoration(
                labelText: 'Match',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: predictionController,
              decoration: const InputDecoration(
                labelText: 'Prediction',
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addPrediction,
                child:
                    const Text('Add Free Prediction'),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addVipPrediction,
                child:
                    const Text('Add VIP Prediction'),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: resultController,
              decoration: const InputDecoration(
                labelText: 'Result',
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addResult,
                child: const Text('Add Result'),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Free Predictions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('free_predictions')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final docs = snapshot.data!.docs;

                return Column(
                  children: docs.map((doc) {
                    final data = doc.data()
                        as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        title: Text(data['match']),
                        subtitle:
                            Text(data['prediction']),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deletePrediction(
                                doc.id);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'VIP Predictions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('vip_predictions')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final docs = snapshot.data!.docs;

                return Column(
                  children: docs.map((doc) {
                    final data = doc.data()
                        as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        title: Text(data['match']),
                        subtitle:
                            Text(data['prediction']),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deleteVipPrediction(
                                doc.id);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'Results',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('results')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final docs = snapshot.data!.docs;

                return Column(
                  children: docs.map((doc) {
                    final data = doc.data()
                        as Map<String, dynamic>;

                   return Card(
  margin: const EdgeInsets.symmetric(vertical: 8),
  color: const Color(0xFF1E1E1E),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  child: ListTile(
    title: Text(
      data['match'] ?? '',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    subtitle: Text(
      data['result'] ?? '',
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 16,
      ),
    ),
    trailing: IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () {
        _deleteResult(doc.id);
      },
    ),
  ),
);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}