import 'package:flutter/material.dart';
import 'package:plantsnap/models/plant.dart';

class SavedPlants extends StatefulWidget{
  SavedPlants({super.key});

  State<SavedPlants> createState(){
    return SavedPlantsState();
  }
}

class SavedPlantsState extends State<SavedPlants>{

  List<Plant> plantList = [Plant(name: "Leafy", imgURL: 'assets/images/Leafy.jpg'), Plant(name: "Cherry Blossom", imgURL: 'assets/images/Cherry_Blossom.jpg'), Plant(name: "Monstera", imgURL: 'assets/images/monstera.png'),  ];

  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32), // Dark green color
                minimumSize: const Size.fromHeight(50), // Make the button full-width
              ),
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Text(
                'Add Plant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: plantList.map((plant) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            plant.imgURL!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              plant.name!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      );
  }
}