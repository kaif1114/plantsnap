import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CameraSnapshot extends StatefulWidget{
  CameraSnapshot({super.key});

  State<CameraSnapshot> createState(){
    return CameraSnapshotState();
  }
}

class CameraSnapshotState extends State<CameraSnapshot>{
  File? _imgFile;
    
      void takeSnapshot() async {
        final ImagePicker picker = ImagePicker();
        final XFile? img = await picker.pickImage(
          source: ImageSource.camera, // alternatively, use ImageSource.gallery
          maxWidth: 400,
        );
        if (img == null) return;
        setState(() {
          _imgFile = File(img.path); // convert it to a Dart:io file
        });
      }

    Future<void> getImageFromCamera() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    // Handle the picked image file
     final imageProvider = FileImage(File(pickedFile.path));
  } else {
    print('User canceled the image picker');
  }
}
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(child: ElevatedButton(onPressed: getImageFromCamera, child: Text("Capture Image"),),),
    );
  }

}


