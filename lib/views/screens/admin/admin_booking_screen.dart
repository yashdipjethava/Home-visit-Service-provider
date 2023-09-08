
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common_widget/job_service_widget.dart';

class AdminBookingScreen extends StatelessWidget {
  const AdminBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: StreamBuilder(
            stream:FirebaseFirestore.instance.collection('bookings').doc(user!.uid).collection("user_bookings").snapshots(),
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: JobServiceWidget(
                        title: records['title'],
                        details: records['details'],
                        image: records['image'],
                        price: records['price'],
                        name: records['name'],
                        number: records['mobile'],
                        address: records['address'],
                        date: records['date_time'],
                        deleteData: recordData[index].id,
                      ),
                    );
                },
              );
            },
          ),
    );
  }
}