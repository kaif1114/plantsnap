import 'package:flutter/material.dart';

class MyLibrary extends StatefulWidget{
  MyLibrary({super.key});

  State<MyLibrary> createState(){
    return MyLibraryState();
  }
}

class MyLibraryState extends State<MyLibrary>{

  Widget build(BuildContext context){
    return Center(child: Text("My Library Screen"
    ),);
  }
}