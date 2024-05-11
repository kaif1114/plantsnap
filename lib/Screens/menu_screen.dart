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
  // Plant? featuredPlant = Plant(name: "FICUS ELASTICA", images: {"original_url": "https://s3-alpha-sig.figma.com/img/6753/8499/cd36bbec6d3eb630e3d678cd0726fcbc?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CD~3CZeY9ZqTnNzLcfwq-CuXbpBYUCKi7OdzuVZcQ3SVlYmdTpagFSWfloSglRy1a3JpB7BH0Pg6DIpdyjcAMDqHD7rh-2d~VGfTIMUidqi2TFY~RjmHfJUp0qsDeNP9pDjG3rS04SgxbI34XQUR-pOPw01t26PDpGcdZ-sqbt4EWmi2FNh-ADTxC4QHHnz~vSS4UsMAYQ3FSYCliMRjdE~pXehnhIBkt-4vA8KKRmiwJUGc6ggkcjzlEdJxf8mBP692e~tEMFO7G-XP8gFLPhk1WIyMulYdwedFJf5h7LZ1XWJkhwmHkI4zT8kxBI-4OaQFhnPA5J9kEPCKoxbLZw__"});

  Future<void> getFeaturedPlantData() async {
    print("getFeaturedPlantData function called");
    // featuredPlant = await perenualService.getRandomPlant();
    // Plant? ezpz =  await perenualService.getRandomPlant();
    // setState(() {
    //   featuredPlant = ezpz;
    //   if(featuredPlant?.name !=null){
    //     print(featuredPlant!.name);
    //   }
    //   if(featuredPlant?.cycle !=null){
    //     print(featuredPlant!.cycle);
    //   }
    //   if(featuredPlant?.sunlight !=null){
    //     print(featuredPlant!.sunlight);
    //   }
    //   if(featuredPlant?.type !=null){
    //     print(featuredPlant!.type);
    //   }
    //   if(featuredPlant?.description !=null){
    //     print(featuredPlant!.description);
    //   }
    //   if(featuredPlant?.scientificName !=null){
    //     print(featuredPlant!.scientificName);
    //   }
    //   if(featuredPlant?.watering !=null){
    //     print(featuredPlant!.watering);
    //   }
    //   if(featuredPlant?.images?["original_url"] !=null){
    //     print(featuredPlant!.images!["original_url"]);
    //   }

    // });
  }

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
            return Center(child: CircularProgressIndicator(),);
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
                                    )
                                    // Image.asset(
                                    //   'assets/images/house-plant.jpeg',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 160,
                              child: Text(
                                featuredPlantData.name.toString(),
                                style: GoogleFonts.quantico(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic),
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
                            child: Text(
                              "All Categories",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 122, 146, 92),
                                foregroundColor: Colors.white)),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "All Categories",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 122, 146, 92),
                                foregroundColor: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          else{
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
