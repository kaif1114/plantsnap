import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:plantsnap/Screens/plant_details.dart';

class CameraSnapshot extends StatefulWidget {
  CameraSnapshot({super.key});

  State<CameraSnapshot> createState() {
    return CameraSnapshotState();
  }
}

class CameraSnapshotState extends State<CameraSnapshot> {
  File? _imgFile;
  bool isLoading = false;

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
    setState(() {
      isLoading = true;
    });
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
    Uri url = Uri.parse(
        "https://plant.id/api/v3/identification?details=common_names,url,description,taxonomy,rank,gbif_id,inaturalist_id,image,synonyms,edible_parts,watering&language=en");
    var body = json.encode({
      "images": ["data:image/jpg;base64,$base64"],
      // "latitude": 49.207,
      // "longitude": 16.608,
      "similar_images": true
    });

    // var request = http.Request(
    //     'POST', Uri.parse('https://plant.id/api/v3/identification'));
    // request.body = json.encode({
    //   "images": ["data:image/jpg;base64,$base64"],
    //   // "latitude": 49.207,
    //   // "longitude": 16.608,
    //   "similar_images": true
    // });
    // request.headers.addAll(headers);
    try {
      var response = await http.post(url, headers: headers, body: body);
      int responseCode = response.statusCode;
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print("Status Code: $responseCode");
        print(responseData);
        return responseData;
      } else {
        return {"StatusCode": response.statusCode};
      }

      // http.StreamedResponse streamedResponse = await request.send();
      // // var response = await http.Response.fromStream(streamedResponse);
      // var responsePhrase = streamedResponse.reasonPhrase;
      // int responseCode = streamedResponse.statusCode;
      // Map<String, dynamic> responseData;

      // if (streamedResponse.statusCode == 200 ||
      //     streamedResponse.statusCode == 201) {
      //   var response =
      //       await streamedResponse.stream.toString() as Map<String, dynamic>;

      //   print("ReasonPhrase: $responsePhrase");
      //   print("StatusCode : $responseCode");
      //   print(response);
      //   responseData = response;
      //   return responseData;
      //   // responseData = json.decode(response.body);
      // } else {
      //   return {"reasonphrase": responsePhrase, "responseCode": responseCode};
      // }
    } catch (e) {
      throw Exception(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  await getImageFromCamera();

                  if (_imgFile != null) {
                    bool isUploaded = await uploadFileForUser();
                    if (isUploaded == true) {
                      print("Upload success!");
                      String base64 = imageToBase64();
                      // print(base64);
                      Map<String, dynamic> plantDetails =
                          await identifyImage(base64);
                      String imageURL = plantDetails["result"]["classification"]
                          ["suggestions"][0]["similar_images"][0]["url"];
                      String plantName = plantDetails["result"]
                          ["classification"]["suggestions"][0]["name"];
                      String plantKingdom = plantDetails["result"]
                              ["classification"]["suggestions"][0]["details"]
                          ["taxonomy"]["kingdom"];
                      String plantFamily = plantDetails["result"]
                              ["classification"]["suggestions"][0]["details"]
                          ["taxonomy"]["family"];
                      String commonName = plantDetails["result"]
                              ["classification"]["suggestions"][0]["details"]
                          ["common_names"][0];
                      String plantDescription = plantDetails["result"]
                              ["classification"]["suggestions"][0]["details"]
                          ["description"]["value"];

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PlantDetails(
                          name: plantName,
                          imageURL: imageURL,
                          kingdom: plantKingdom,
                          family: plantFamily,
                          commonName: commonName,
                          description: plantDescription,
                        );
                      }));

                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      print("upload failed!");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(121, 147, 92, 1), foregroundColor: Colors.white),
                child: Text("Capture Image", style: GoogleFonts.lato(fontSize: 15),),
              ),
      ),
    );
  }
}
