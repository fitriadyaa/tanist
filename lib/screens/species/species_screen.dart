import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpeciesScreen extends StatefulWidget {
  const SpeciesScreen({super.key});

  @override
  State<SpeciesScreen> createState() => _SpeciesScreenState();
}

class _SpeciesScreenState extends State<SpeciesScreen> {
  Future<List<String>> fetchSpecies() async {
    final url = Uri.parse('https://plants10.p.rapidapi.com/plants?limit=10');
    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-key': '',
        'x-rapidapi-host': 'plants10.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> speciesList = List<dynamic>.from(data['plants'] ?? []);
      return speciesList.map((s) => s['scientific_name'].toString()).toList();
    } else {
      throw Exception('Failed to load species');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spesies'),
        backgroundColor: const Color(0xFF219653),
      ),
      body: SafeArea(
        child: FutureBuilder<List<String>>(
          future: fetchSpecies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color(0xFF219653),
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  if (snapshot.data == null || index >= snapshot.data!.length) {
                    return const ListTile(
                      title: Text('No Data'),
                    );
                  } else {
                    return ListTile(
                      title: Text(
                        snapshot.data![index],
                        selectionColor: Colors.black,
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
