import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plantsnap/Screens/plant_details.dart';
import 'package:plantsnap/Services/firestore_service.dart';
import 'package:plantsnap/models/plant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/Screens/Camera.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedPlants extends StatefulWidget {
  SavedPlants({super.key});

  @override
  State<SavedPlants> createState() {
    return SavedPlantsState();
  }
}

class SavedPlantsState extends State<SavedPlants> {
  FirestoreService firestoreService = FirestoreService();
  StreamController<List<Map<String, dynamic>>> savedPlantsStream =
      StreamController<List<Map<String, dynamic>>>();

  Future<void> getSavedPlants() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print("USER ID: $userId");
    List<Map<String, dynamic>> savedPlants =
        await firestoreService.getAllDocuments(userId!);
    print(savedPlants);
    savedPlantsStream.add(savedPlants);
  }

  @override
  void initState() {
    super.initState();
    getSavedPlants();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: savedPlantsStream.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          if (snapshot.data![0]["docId"] == "dummy") {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  
                  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2E7D32), // Dark green color
                      minimumSize: const Size.fromHeight(
                          50), // Make the button full-width
                    ),
                    onPressed: (){
                      getSavedPlants();
                    },
                    child: const Text(
                      'Refresh',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text("No Saved Plants. Start by scanning a plant!"),
                  ),
                ],
              ),
            );
          }
          // Process snapshot data if necessary and update plantList accordingly
          return Padding(padding: const EdgeInsets.all(16), child: Column(
            children: [
              
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2E7D32), // Dark green color
                      minimumSize: const Size.fromHeight(
                          50), // Make the button full-width
                    ),
                    onPressed: (){
                      getSavedPlants();
                    },
                    child: const Text(
                      'Refresh',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
              Expanded(
                
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> savedPlant = snapshot.data![index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PlantDetails(
                                name: savedPlant["plantName"],
                                imageURL: savedPlant["imageURL"],
                                description: savedPlant["plantDescription"],
                                kingdom: savedPlant["plantKingdom"],
                                family: savedPlant["plantFamily"],
                                commonName: savedPlant["commonName"]);
                          }));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          margin: const EdgeInsets.all(6),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(60),
                                      child: Image.network(
                                        savedPlant["imageURL"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    savedPlant["plantName"],
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ));
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
