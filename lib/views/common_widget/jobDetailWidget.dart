// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:voloc/views/screens/service_book_screen.dart';

class JobDetailWidget extends StatelessWidget {
  const JobDetailWidget({
    required this.price,
    required this.details,
    required this.image,
    required this.title,
  });

  final price;
  final details;
  final image;
  final title;

  @override
  Widget build(BuildContext context) {
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
                                    fontSize: 16.0, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
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
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
