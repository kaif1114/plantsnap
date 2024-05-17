import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlantDetails extends StatelessWidget {
  const PlantDetails({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: <Widget>[
            // Plant Details Heading with spacing

            const Text(
              'Plant Details',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
                      20.0), // Adjust padding for top, bottom, left, and right
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(50.0), // Set desired radius
                        boxShadow: kElevationToShadow[
                            2], // Import Material for shadows (optional)
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(50.0), // Match border radius
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(
                              75.0), // Adjust size as desired
                          child: Image.asset(
                            'assets/images/house-plant.jpeg', // Replace with your plant image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20.0), // Adjust spacing as desired
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Lemon Bonsai', // Replace with the actual plant name
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),

                  // Row for Humidity and Sunlight
                  const SizedBox(height: 20.0), // Adjust spacing as desired
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Row for Sunlight with Image
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/sunlight.png',
                            width: 30.0,
                            height: 30.0,
                          ),
                          const SizedBox(
                              width:
                                  10.0), // Add spacing between image and text
                          const Text(
                            'Sunlight:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                              ' 20-30%'), // Add space between colon and value
                        ],
                      ),
                      // Row for Humidity with Image
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/humidity.png',
                            width: 30.0,
                            height: 30.0,
                          ),
                          const SizedBox(
                              width:
                                  10.0), // Add spacing between image and text
                          const Text(
                            'Humidity:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                              ' 35-40%'), // Add space between colon and value
                        ],
                      ),
                    ],
                  ),

                  // Description section with padding
                  const SizedBox(height: 20.0),

                  const Align(
                    alignment: Alignment
                        .topLeft, // Adjust alignment as needed (topLeft for top left corner)
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),

                  const SizedBox(
                    child: Text(
                      'The Weeping fig (Ficus Benjamina) is a popular houseplant known for its lush foliage and cascading branches. It is a relatively low-maintenance plant that can thrive in a variety of indoor conditions. However, it is important to provide it with the right amount of sunlight and humidity to keep it healthy.',
                      style: TextStyle(
                          fontSize: 16.0), // Adjust font size as desired
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
