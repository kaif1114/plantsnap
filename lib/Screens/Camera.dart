import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CameraSnapshot extends StatefulWidget {
  CameraSnapshot({super.key});

  State<CameraSnapshot> createState() {
    return CameraSnapshotState();
  }
}

class CameraSnapshotState extends State<CameraSnapshot> {
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
      final _imgFile = pickedFile;
      final imageProvider = FileImage(File(pickedFile.path));
    } else {
      print('User canceled the image picker');
    }
  }

  Future<bool> uploadFileForUser() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref();
      if (_imgFile != null) {
        final fileName = _imgFile!.path.split("/").last;
        final timestamp = DateTime.now().microsecondsSinceEpoch;
        final uploadRef =
            storageRef.child("$userId/uploads/$timestamp-$fileName");
        await uploadRef.putFile(_imgFile!);
        return true;
      } else {
        print("_imgFile is null!!!");
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await getImageFromCamera();
            if (_imgFile != null) {
              bool isUploaded = await uploadFileForUser();
              if (isUploaded == true) {
                print("Upload success!");
              } else {
                print("upload failed!");
              }
            }
          },
          child: Text("Capture Image"),
        ),
      ),
    );
  }
}
