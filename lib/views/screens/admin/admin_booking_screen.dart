import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voloc/views/common_widget/booking_statusWise.dart';

class AdminBookingScreen extends StatefulWidget {
  const AdminBookingScreen({super.key});

  @override
  State<AdminBookingScreen> createState() => _AdminBookingScreenState();
}

class _AdminBookingScreenState extends State<AdminBookingScreen> {
  String dropdownValue = 'all'; // Initialize the dropdown value
  Stream<QuerySnapshot>? currentStream;

  @override
  void initState() {
    super.initState();
    // Initially, set the stream based on the default dropdown value
    currentStream = getStreamForDropDownValue(dropdownValue);
  }

  Stream<QuerySnapshot>? getStreamForDropDownValue(String value) {
    switch (value) {
      case "all":
        return FirebaseFirestore.instance
            .collection('bookings')
            .doc('OyyVyUTow1dKiARbGjliFRGTuMt2')
            .collection("user_bookings")
            .snapshots();
      case "confirmed":
        return FirebaseFirestore.instance
            .collection('bookings')
            .doc('OyyVyUTow1dKiARbGjliFRGTuMt2')
            .collection("user_bookings")
            .where('booking status', isEqualTo: "confirm")
            .snapshots();
      case "cancelled":
        return FirebaseFirestore.instance
            .collection('bookings')
            .doc('OyyVyUTow1dKiARbGjliFRGTuMt2')
            .collection("user_bookings")
            .where('booking status', isEqualTo: "cancel")
            .snapshots();
      case "completed":
        return FirebaseFirestore.instance
            .collection('bookings')
            .doc('OyyVyUTow1dKiARbGjliFRGTuMt2')
            .collection("user_bookings")
            .where('booking status', isEqualTo: "complete")
            .snapshots();
      default:
        return FirebaseFirestore.instance
            .collection('bookings')
            .doc('OyyVyUTow1dKiARbGjliFRGTuMt2')
            .collection("user_bookings")
            .snapshots();
    }
  }

  void onLongPress(String docId, String userId) async {
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
                title: const Text('set order as completed'),
                onTap: () async {
                  Navigator.pop(context);
                  await FirebaseFirestore.instance
                      .collection("bookings")
                      .doc(userId)
                      .collection("user_bookings")
                      .doc(docId)
                      .update({"booking status": "complete"});
                  await FirebaseFirestore.instance
                      .collection("bookings")
                      .doc('OyyVyUTow1dKiARbGjliFRGTuMt2')
                      .collection("user_bookings")
                      .doc(docId)
                      .update({"booking status": "complete"});
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: DropdownButton<String>(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              value: dropdownValue,
              items: const [
                DropdownMenuItem(value: 'all', child: Text("all")),
                DropdownMenuItem(value: 'confirmed', child: Text("confirmed")),
                DropdownMenuItem(value: 'cancelled', child: Text("cancelled")),
                DropdownMenuItem(value: 'completed', child: Text("completed")),
              ],
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                  currentStream = getStreamForDropDownValue(value);
                });
              },
            ),
          ),
          StreamBuilder(
            stream: currentStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // Show loading indicator while data is loading
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                final recordData = snapshot.data!.docs;
                return SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: recordData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final records =
                          recordData[index].data() as Map<String, dynamic>;
                      // Check if image URL is available before creating the widget
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: GestureDetector(
                          onLongPress: () {
                            return onLongPress(
                                recordData[index].id, records['userId']);
                          },
                          child: StatusBookingWidget(
                            title: records['title'],
                            details: records['details'],
                            image: records['image'],
                            price: records['price'],
                            name: records['name'],
                            number: records['mobile'],
                            address: records['address'],
                            date: records['date_time'],
                            deleteData: recordData[index].id,
                            bookingStatus: records['booking status'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text("You do not have bookings"),
              );
            },
          ),
        ],
      ),
    );
  }
}
