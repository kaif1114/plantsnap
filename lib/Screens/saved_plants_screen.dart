import 'package:flutter/material.dart';

class SavedPlants extends StatefulWidget{
  SavedPlants({super.key});

  State<SavedPlants> createState(){
    return SavedPlantsState();
  }
}

class SavedPlantsState extends State<SavedPlants>{

  Widget build(BuildContext context){
    return Center(child: Text("Saved Plants Screen"
    ),);
  }
}