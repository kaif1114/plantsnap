import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/Screens/menu_screen.dart';

class PlantDetails extends StatelessWidget {
  PlantDetails(
      {super.key,
      required this.name,
      required this.imageURL,
      required this.description,
      required this.kingdom,
      required this.family,
      required this.commonName});

  String name, imageURL, description, kingdom, family, commonName;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Plant Details Heading with spacing
              const SizedBox(height: 20,),
              Text(
                'Plant Details',
                style: GoogleFonts.lato(
                    fontSize: 30.0, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              // Green Background Image with centered circular plant image
              Stack(
                children: <Widget>[
                  // Background Image with adjusted height (optional)
                  Image.asset(
                    'assets/images/green.png', // Replace with your green background image path
                    fit: BoxFit.cover,
                    height: 220.0, // Adjust height as desired
                  ),
                  // Center the circular image container with some padding (adjust as needed)
                  Padding(
                    padding: const EdgeInsets.all(
                        0), // Adjust padding for top, bottom, left, and right
                    child: Center(
                      child: CircleAvatar(
                        radius: 110,
                        backgroundImage: NetworkImage(imageURL),
                        // backgroundImage: Image.network(
                        //   plantDetails["result"]["classification"]["suggestions"][0]["similar_images"][0]["url"],
                        // ) as ImageProvider,
                      ),
                      // child: Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //         BorderRadius.circular(350.0), // Set desired radius
                      //     boxShadow: kElevationToShadow[
                      //         2], // Import Material for shadows (optional)
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius:
                      //         BorderRadius.circular(50.0), // Match border radius
                      //     child: SizedBox.fromSize(
                      //       size: const Size.fromRadius(
                      //           110.0), // Adjust size as desired
                      //       child: Image.asset(
                      //         'assets/images/house-plant.jpeg', // Replace with your plant image path
                      //         fit: BoxFit.cover,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0), // Adjust spacing as desired
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        name, // Replace with the actual plant name
                        style: GoogleFonts.lato(
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Kingdom",
                              style: GoogleFonts.lato(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            Text(kingdom),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Family",
                              style: GoogleFonts.lato(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            Text(family),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Common Name",
                              style: GoogleFonts.lato(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            Text(commonName),
                          ],
                        ),
                      ],
                    ),
                    // Row for Humidity and Sunlight
                    const SizedBox(height: 20.0), // Adjust spacing as desired
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     // Row for Sunlight with Image
                    //     Row(
                    //       children: <Widget>[
                    //         Image.asset(
                    //           'assets/images/sunlight.png',
                    //           width: 30.0,
                    //           height: 30.0,
                    //         ),
                    //         const SizedBox(
                    //             width:
                    //                 10.0), // Add spacing between image and text
                    //         Text(
                    //           'Sunlight:',
                    //           style:
                    //               GoogleFonts.lato(fontWeight: FontWeight.bold),
                    //         ),
                    //         const Text(
                    //             ' 20-30%'), // Add space between colon and value
                    //       ],
                    //     ),
                    //     // Row for Humidity with Image
                    //     Row(
                    //       children: <Widget>[
                    //         Image.asset(
                    //           'assets/images/humidity.png',
                    //           width: 30.0,
                    //           height: 30.0,
                    //         ),
                    //         const SizedBox(
                    //             width:
                    //                 10.0), // Add spacing between image and text
                    //         Text(
                    //           'Humidity:',
                    //           style:
                    //               GoogleFonts.lato(fontWeight: FontWeight.bold),
                    //         ),
                    //         const Text(
                    //             ' 35-40%'), // Add space between colon and value
                    //       ],
                    //     ),
                    //   ],
                    // ),

                    // // Description section with padding
                    // const SizedBox(height: 20.0),

                    Align(
                      alignment: Alignment
                          .topLeft, // Adjust alignment as needed (topLeft for top left corner)
                      child: Text(
                        'Description',
                        style: GoogleFonts.lato(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),

                    SizedBox(
                      child: Text(
                        description,
                        style: GoogleFonts.lato(
                            fontSize: 16.0), // Adjust font size as desired
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Featured Plants",
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PlantCardScroll(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
