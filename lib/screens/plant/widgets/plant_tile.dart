// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:tanist/screens/plant/plant_detail_screen.dart';
import 'package:tanist/screens/plant/resources/plant_model.dart';

class PlantTile extends StatelessWidget {
  Plant plant;
  PlantTile({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: PlantDetailScreen(plant: plant),
            type: PageTransitionType.rightToLeft,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  plant.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                plant.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    plant.kingdom,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(plant.family),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                plant.desc,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
