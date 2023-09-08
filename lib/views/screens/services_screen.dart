import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../common_widget/jobWidget.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "OUR ALL SERVICES",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('services').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator while data is loading
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final recordData = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: recordData.length,
                    shrinkWrap: true,
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
