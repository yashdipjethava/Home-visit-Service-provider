// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/service_book_screen.dart';

class JobServiceDetailWidget extends StatelessWidget {
  const JobServiceDetailWidget({
    required this.price,
    required this.details,
    required this.image,
    required this.title,
    this.name,
    this.number,
    this.address,
    this.date,
    this.deleteData,
  });

  final price;
  final details;
  final image;
  final title;
  final name;
  final number;
  final address;
  final date;
  final deleteData;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat('yyyy-MM-dd');
    final dt = format.format(DateTime.now());
    final subdate = date.toString().substring(0, 10);
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
                FadeInImage(
                  placeholder: NetworkImage(
                    '$image',
                  ),
                  image: NetworkImage('$image'),
                  height: MediaQuery.of(context).size.height / 2,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Customer Name:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$name",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Customer Number:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$number",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Customer Address:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$address",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                // Product title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Service:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$title",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // Product description
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Details:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$details",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                // Product price
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Price:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$price",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Date:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$date",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Payment Via:",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Cash On Service",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    width: double.infinity,
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
                        'BOOK AGAIN',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent),
                    child: subdate == dt
                        ? TextButton(
                            onPressed: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              await FirebaseFirestore.instance
                                  .collection("bookings")
                                  .doc(user!.uid)
                                  .collection("user_bookings")
                                  .doc(deleteData)
                                  .delete();
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: const Text(
                                          "Your service is cancelled"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Okay"))
                                      ],
                                    );
                                  });
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black87),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
