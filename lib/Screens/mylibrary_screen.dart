import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyLibrary extends StatefulWidget {
  MyLibrary({super.key});

  State<MyLibrary> createState() {
    return MyLibraryState();
  }
}

class MyLibraryState extends State<MyLibrary> {
  List<Reference> _uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    getUploadedFiles();
  }

  Future<List<Reference>?> getUsersUplodedFiles() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref();
      final uploadsRefs = storageRef.child("$userId/uploads");
      final uploads = await uploadsRefs.listAll();
      return uploads.items;
    } catch (e) {
      print(e);
    }
  }

  Widget _buildUI() {
    if (_uploadedFiles.isEmpty) {
      return const Center(
        child: Text("No files uploaded yet."),
      );
    }
    return ListView.builder(
      itemCount: _uploadedFiles.length,
      itemBuilder: (context, index) {
        Reference ref = _uploadedFiles[index];
        return FutureBuilder(
          future: ref.getDownloadURL(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50), child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: kElevationToShadow[2],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: AspectRatio(
                    aspectRatio: 1.3, // You can adjust the aspect ratio if needed
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire container
                    ),
                  ),
                ),
              ));
            }
            return Container();
          },
        );
      },
    );
  }

  void getUploadedFiles() async {
    List<Reference>? result = await getUsersUplodedFiles();
    if (result != null) {
      setState(
        () {
          _uploadedFiles = result;
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return _buildUI();
  }
}
