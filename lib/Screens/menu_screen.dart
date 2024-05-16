import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/Screens/Camera.dart';
import 'package:plantsnap/models/plant.dart';
import 'package:plantsnap/Services/perenual_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:plantsnap/Screens/mylibrary_screen.dart';
import 'package:plantsnap/Screens/saved_plants_screen.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key, required this.currentUser});

  User currentUser;

  State<MenuScreen> createState() {
    return MenuScreenState();
  }
}

class MenuScreenState extends State<MenuScreen> {
  
  int currentIndex = 0;
  List<Widget> MenuScreens = [HomePage(), CameraSnapshot(), MyLibrary(), SavedPlants(),];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          onPressed: () {
            return Scaffold.of(context).openDrawer();
          },
          icon: const ImageIcon(
            AssetImage('assets/images/drawer-icon.png'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              size: 40,
              AssetImage(
                'assets/images/profile-icon.png',
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: currentIndex, children: MenuScreens,),
      bottomNavigationBar: SalomonBottomBar(
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 121, 147, 92),
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items:  [
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.home,
              size: 33,
            ),
            title: const Text("Home"),
          ),
          SalomonBottomBarItem(
              icon: const ImageIcon(
                size: 32,
                AssetImage('assets/images/camera-icon.png'),
              ),
              title: const Text("Camera")),
          SalomonBottomBarItem(
              icon: const ImageIcon(
                size: 32,
                AssetImage('assets/images/book-icon.png'),
              ),
              title: const Text("My Library")),
          SalomonBottomBarItem(
              icon: const ImageIcon(
                size: 32,
                AssetImage('assets/images/plant-icon.png'),
              ),
              title: const Text("Saved Plants")),
        ],
      ),
    );
  }
}

class PlantCardScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // Number of cards
        itemBuilder: (context, index) {
          // Dummy data array for demonstration; replace with your data source
          List<Map<String, String>> plantData = [
            {"name": "Snake Plant", "image": "assets/images/house-plant.jpeg"},
            {
              "name": "Syngonium Plant",
              "image": "assets/images/house-plant.jpeg"
            },
            // Add more plants as needed
          ];

          return Container(
            width: 160, // Adjust width as needed
            padding: EdgeInsets.all(8),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: kElevationToShadow[2],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(100),
                          child: Image.asset(
                            plantData[index % plantData.length]["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      plantData[index % plantData.length]["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle your button tap here
                        print('Explore tapped');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(121, 147, 92, 1),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        // minimumSize: Size(0, 0),
                      ),
                      child: Text(
                        'EXPLORE',
                        style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget{
  HomePage({super.key});

  State<HomePage> createState(){
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  final perenualService = PerenualService();
  late Future<Plant?> featuredPlant;

  void initState() {
    super.initState();
    featuredPlant = perenualService.getRandomPlant();
  }

  Widget build(BuildContext context){
    return FutureBuilder(
        future: featuredPlant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Plant featuredPlantData = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/images/green-card.png'),
                      Padding(
                        padding: EdgeInsets.fromLTRB(4, 25, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: kElevationToShadow[2],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(100),
                                  child: Image.network(
                                    featuredPlantData.images!["original_url"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Center(
                                  child: Text(
                                    featuredPlantData.name.toString(),
                                    style: GoogleFonts.quantico(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/categories-label.png',
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 122, 146, 92),
                              foregroundColor: Colors.white),
                          child: Text(
                            "All Categories",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 122, 146, 92),
                              foregroundColor: Colors.white),
                          child: Text(
                            "All Categories",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Image.asset(
                    'assets/images/popular-plants-label.png',
                    height: 21,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PlantCardScroll(),
                ],
              ),
            );
          } else {
            throw Exception("Future Builder Error");
          }
        },
      );
  }
}