// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tanist/screens/plant/resources/plant_model.dart';

// ignore: must_be_immutable
class PlantDetailScreen extends StatelessWidget {
  Plant plant;
  PlantDetailScreen({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Detail'),
        backgroundColor: const Color(0xFF219653),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(plant.image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: const Text('DANGER'),
                        backgroundColor: Colors.red[200],
                      ),
                      Chip(
                        label: const Text('DECORATION'),
                        backgroundColor: Colors.blue[200],
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    plant.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star_half, color: Colors.amber),
                      Icon(Icons.star_border, color: Colors.grey),
                      Text(' 4.1'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('KINGDOM', style: TextStyle(color: Colors.grey)),
                  Text(plant.kingdom),
                  const SizedBox(height: 8),
                  const Text('FAMILY', style: TextStyle(color: Colors.grey)),
                  Text(plant.family),
                  const SizedBox(height: 8),
                  const Text('DESCRIPTION',
                      style: TextStyle(color: Colors.grey)),
                  Text(
                    plant.desc,
                    textAlign: TextAlign.justify,
                  ),
                  // Add more widgets as needed...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
