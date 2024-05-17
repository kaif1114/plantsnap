import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

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
      print("Inside pickedFile !=null block");
      _imgFile = File(pickedFile.path);
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

  String imageToBase64() {
    List<int> imageBytes = _imgFile!.readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<Map<String, dynamic>> identifyImage(String base64) async {
    var headers = {
      'Api-Key': '9CIweznlABVQkVzBwnK0vq2UvRmAN14SUfgBud4fQxaiUY5Mwm',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://plant.id/api/v3/identification'));
    request.body = json.encode({
      "images": [
        "data:image/jpg;base64,$base64"
      ],
      // "latitude": 49.207,
      // "longitude": 16.608,
      "similar_images": true
    });
    request.headers.addAll(headers);
try{
  http.StreamedResponse streamedResponse = await request.send();
    // var response = await http.Response.fromStream(streamedResponse);

    Map<String, dynamic> responseData;

    if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {

      var response = await streamedResponse.stream.toString() as Map<String, dynamic>;

      var responsePhrase = streamedResponse.reasonPhrase;
      int responseCode = streamedResponse.statusCode;
      print("ReasonPhrase: $responsePhrase");
      print("StatusCode : $responseCode");
      print(response);
      responseData = response;
      return responseData;
      // responseData = json.decode(response.body);
    } 
}
catch(e){
  throw Exception(e);
}
    
    // else {

    //   var responsePhrase = streamedResponse.reasonPhrase;
    //   int responseCode = streamedResponse.statusCode;
    //   print("ReasonPhrase: $responsePhrase");
    //   print("StatusCode : $responseCode");

    // }
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
                String base64 = imageToBase64();
                // print(base64);
                identifyImage(base64);
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
