import 'package:flutter/material.dart';

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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Product image
                Image.network(
                  '$image',
                  height: MediaQuery.of(context).size.height / 1.8,
                  fit: BoxFit.fill,
                ),

                // Product title
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: Text(
                    '$title',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),

                // Product description
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('$details')),

                // Product price
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$price',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orangeAccent
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text('BOOK NOW',style: TextStyle(color: Colors.black87),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
