
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voloc/views/common_widget/jobWidget.dart';
import 'package:voloc/views/screens/services_screen.dart';

import '../common_widget/image_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ServeEasy"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Famous Services",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: CarouselSlider(
              items: const [
                ImagesForSlider(
                    slideImageUrl:
                    'https://s3-ap-southeast-1.amazonaws.com/urbanclap-prod/images/growth/home-screen/1625159882387-9585c7.jpeg',
                    strInfo: 'Clean Your Bathroom',
                    backGroundColor: Colors.orangeAccent),
                ImagesForSlider(
                    slideImageUrl:
                    'https://media.istockphoto.com/id/943322992/vector/painter-painting-wall.jpg?s=612x612&w=0&k=20&c=Q7NiiRQhsrgKIDfG8FU-soxD4WPuf2isXKiDpl9k1sE=',
                    strInfo: 'Paint Your Wall',
                    backGroundColor: Colors.blueAccent),
                ImagesForSlider(
                  slideImageUrl:
                  'https://images.unsplash.com/photo-1615906655593-ad0386982a0f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWVjaGFuaWN8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                  strInfo: 'Repair Your Vehicle',
                  backGroundColor: Colors.grey,
                ),
                ImagesForSlider(
                  slideImageUrl:
                  'https://img.freepik.com/premium-photo/barber-man-with-beard-process-cutting-client-pair-scissors-barbershop_154092-8880.jpg?w=2000',
                  strInfo: 'Haircut At Home',
                  backGroundColor: Colors.greenAccent,
                ),
              ],
              options: CarouselOptions(
                  viewportFraction: 1,
                  height: 210,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 1,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  aspectRatio: 0.1),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Services',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServiceScreen(),
                    )),
                child: const Text('see more',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
          StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('services').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Show loading indicator while data is loading
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final recordData = snapshot.data!.docs;
              return ListView.builder(
                itemCount: recordData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final records =
                  recordData[index].data() as Map<String, dynamic>;

                  // Check if image URL is available before creating the widget
                  if (records.containsKey('image') &&
                      records['image'] != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: JobWidget(
                        title: records['title'],
                        details: records['details'],
                        image: records['image'],
                        price: records['price'],
                      ),
                    );
                  } else {
                    return const SizedBox
                        .shrink(); // Empty widget if image is not available
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
