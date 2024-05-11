import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/models/plant.dart';
import 'package:plantsnap/Services/perenual_service.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  State<MenuScreen> createState() {
    return MenuScreenState();
  }
}

class MenuScreenState extends State<MenuScreen> {
  final perenualService = PerenualService();
  late Future<Plant?> featuredPlant;

  @override
  void initState() {
    super.initState();
    featuredPlant = perenualService.getRandomPlant();
  }

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
      body: FutureBuilder(
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
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            // Container(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 10),
                            //   width: 165,
                            //   child: Center(
                            //     child: Text(
                            //     featuredPlantData.name.toString(),
                            //     style: GoogleFonts.quantico(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.w700,
                            //         fontSize: 20,
                            //         fontStyle: FontStyle.italic),
                            //   ),
                            //   )
                            // )
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
                  )
                ],
              ),
            );
          } else {
            throw Exception("Future Builder Error");
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                size: 30,
                AssetImage('assets/images/camera-icon.png'),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: ImageIcon(
                size: 30,
                AssetImage('assets/images/book-icon.png'),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: ImageIcon(
                size: 30,
                AssetImage('assets/images/plant-icon.png'),
              ),
              label: ""),
        ],
      ),
    );
  }
}
