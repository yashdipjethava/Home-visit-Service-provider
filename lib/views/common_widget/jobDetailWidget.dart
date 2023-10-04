// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:voloc/views/screens/service_book_screen.dart';

class JobDetailWidget extends StatelessWidget {
  const JobDetailWidget({
    required this.price,
    required this.details,
    required this.image,
    required this.title,
    this.revser,
  });

  final price;
  final details;
  final image;
  final title;
  final revser;

  @override
  Widget build(BuildContext context) {
    final record = FirebaseFirestore.instance.collection("reviews").doc(revser).collection('review');
    final reviewController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Product image
                Hero(
                  tag: image,
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage('$image'),
                    height: MediaQuery.of(context).size.height / 2,
                    fit: BoxFit.fill,
                  ),
                ),

                // Product title
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        "Service:-",
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$title',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ],
                  ),
                ),

                // Product description
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Details:-",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text('$details'),
                      ],
                    )),

                // Product price
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orangeAccent),
                          child: Column(
                            children: [
                              const Text(
                                "Price",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₹$price',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orangeAccent),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ServiceBookScreen(
                                        title: title,
                                        image: image,
                                        details: details,
                                        price: price,
                                      )));
                            },
                            child: const Text(
                              'BOOK NOW',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Customer Reviews",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder(
                  future: record.get(),
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator while fetching data
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Not Revies Yet'),
            );
          }
                    final listData = snapshot.data!.docs;
                    
                    return ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 1000),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                             return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      foregroundImage: NetworkImage('${listData[index]['user_image']}'),
                                      backgroundImage: const AssetImage('assets/img/person.png'),
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("${listData[index]['name']}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${listData[index]['time']}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${listData[index]['review']}"),
                              ),
                              const Divider(thickness: 1 ,)
                            ],
                          );                      
                        }),
                  );
                  },
                  
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(   
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      hintText: "Write Review"),
                  controller: reviewController,
                ),
              )),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton.icon(
                      onPressed: () async {
                        if(reviewController.text.isEmpty){
                          return;
                        }
                        final user = FirebaseAuth.instance.currentUser!.uid;
                        final datetime = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
                        final userRef = FirebaseFirestore.instance
                            .collection('users')
                            .doc(user);
                        userRef.snapshots().listen((DocumentSnapshot snapshot) {
                          final userData =
                              snapshot.data() as Map<String, dynamic>;
                          FirebaseFirestore.instance
                              .collection('reviews')
                              .doc(revser).
                              collection("review")
                              .doc("$revser$user")
                              .set({
                              'name': userData['username'] as String,
                              'review': reviewController.text,
                              'user_image': userData['image'],
                              'time': datetime
                          });
                          reviewController.clear();
                          FocusScope.of(context).unfocus();
                        });
                      },
                      icon: const Icon(Icons.send),
                      label: const Text("Review")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
