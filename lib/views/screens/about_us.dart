import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  final String welcome =
      "At ServeEasy we're dedicated to simplifying your life through seamless connections with service providers. Our journey began with a simple vision: to create a platform that makes accessing services effortless. Today, we take pride in offering an app that transforms the way you experience convenience and reliability in everyday tasks.";
  final String mission = "Our mission is crystal clear: to empower individuals and businesses by making top-quality services accessible and straightforward. We aim to bridge the gap between service providers and those seeking their expertise, ensuring a mutually beneficial relationship. At ServeEasy, we believe that everyone deserves hassle-free, dependable, and transparent service interactions, and we're committed to delivering just that.";
  final String values = "\tCustomer-Centric: You, our users, are the heartbeat of ServeEasy. Your satisfaction drives everything we do, and we continuously strive to enhance your experience.\n\tInnovation: We're committed to staying at the forefront of technology and trends, guaranteeing that our platform is always modern and user-friendly.\n\tReliability: Trust is paramount in the service industry, and we're devoted to connecting you with reliable and trustworthy service providers.\n\tCommunity: We're passionate about nurturing a sense of community within our platform, connecting people with services that enhance their lives.";
  final String team = "Behind the scenes, there's a dedicated and diverse team propelling ServeEasy forward. Our team members are experts in their respective fields, from app development to customer support. We are united by a common goal: to make your life more convenient and enjoyable.";
  final String journey = "We're excited about the path ahead and the potential for growth and innovation in the service provider industry. Come join us on this thrilling journey, and together, we can make accessing services more convenient than ever before.Thank you for choosing ServeEasy for all your service needs. We eagerly await the opportunity to serve you and provide the convenience, reliability, and quality you deserve.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to ServeEasy",
                  style: TextStyle(fontSize: 22, color: Colors.teal),
                ),
                const SizedBox(height: 5,),
                Text(welcome,softWrap: true,textAlign: TextAlign.justify),
                const SizedBox(height: 10,),
                const Text(
                  "Our Mission",
                  style: TextStyle(fontSize: 22, color: Colors.teal),
                ),
                const SizedBox(height: 5,),
                Text(mission,softWrap: true,textAlign: TextAlign.justify),
                const SizedBox(height: 10,),
                const Text(
                  "Our Values",
                  style: TextStyle(fontSize: 22, color: Colors.teal),
                ),
                const SizedBox(height: 5,),
                Text(values,softWrap: true,textAlign: TextAlign.justify),
                const SizedBox(height: 10,),
                const Text("Meet Our Team",
                style: TextStyle(fontSize: 22, color: Colors.teal),),
                const SizedBox(height: 5,),
                Text(team,softWrap: true,textAlign: TextAlign.justify),
                const SizedBox(height: 10,),
                const Text("Join Us on Our Journey",
                style: TextStyle(fontSize: 22, color: Colors.teal),
                ),
                const SizedBox(height: 5,),
                Text(journey,softWrap: true,textAlign: TextAlign.justify),
                const SizedBox(height: 10,),
                const Text("Contact us",style: TextStyle(fontSize: 22, color: Colors.teal),),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal:16.0),
                  child: Row(
                    children: [
                      Text("Mobile"),
                      SizedBox(width: 19,),
                      Text("7435038855"),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal:16.0),
                  child: Row(
                    children: [
                      Text("Email"),
                      SizedBox(width: 29,),
                      Text("pyajfoundation0211@gmail.com"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
