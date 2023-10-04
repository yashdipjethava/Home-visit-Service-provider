
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voloc/views/screens/admin/update_screen.dart';

import '../../common_widget/jobWidget.dart';

class AdminSerUpDelete extends StatelessWidget {
  const AdminSerUpDelete({Key? key}) : super(key: key);

  Future<void> deleteRecord(BuildContext context, DocumentReference reference) async {
    try {
      await reference.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Record deleted successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('some error with deleting record'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('services').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading indicator while data is loading
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final recordData = snapshot.data!.docs;

          return ListView.builder(
            itemCount: recordData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final records = recordData[index].data() as Map<String, dynamic>;

              void onLongPress() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Options'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text('Update'),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                    documentID: recordData[index].id, // Pass the document ID
                                    records: records,
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            title: const Text('Delete'),
                            onTap: () {
                              deleteRecord(context, recordData[index].reference);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }


              // Check if image URL is available before creating the widget
              if (records.containsKey('image') &&
                  records['image'] != null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  child: GestureDetector(
                    onLongPress: onLongPress,
                    child: JobWidget(
                      title: records['title'],
                      details: records['details'],
                      image: records['image'],
                      price: records['price'],
                    ),
                  ),
                );
              } else {
                return const SizedBox
                    .shrink(); // Empty widget if image is not available
              }
            },
          );
        },
      ),
    );
  }
}

