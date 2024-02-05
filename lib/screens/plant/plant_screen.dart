import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tanist/screens/plant/resources/plant_database.dart';
import 'package:tanist/screens/plant/resources/plant_model.dart';
import 'package:tanist/screens/plant/widgets/plant_tile.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final PlantDatabase plantDatabase = PlantDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Tanaman'),
        backgroundColor: const Color(0xFF219653),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: plantDatabase.streamArticle(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            }

            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  Plant plant = Plant.fromFirestore(docs[index]);
                  return PlantTile(
                    plant: plant,
                  );
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
