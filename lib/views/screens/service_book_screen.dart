// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceBookScreen extends StatefulWidget {
  const ServiceBookScreen(
      {super.key, this.title, this.price, this.image, this.details});
  final title;
  final price;
  final image;
  final details;

  @override
  State<ServiceBookScreen> createState() => _ServiceBookScreenState();
}

class _ServiceBookScreenState extends State<ServiceBookScreen> {
  final _nameController = TextEditingController();

  final _mobController = TextEditingController();

  final _addressController = TextEditingController();

  final _bookKey = GlobalKey<FormState>();

  var isLoading = false;
  final format = DateFormat('yyyy-MM-dd - kk:mm');
  _book(context) async {
    if (_bookKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final dt = format.format(DateTime.now());
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(user!.uid)
          .collection("user_bookings")
          .doc()
          .set({
        "name": _nameController.text,
        "image": widget.image,
        "title": widget.title,
        "price": widget.price,
        "details": widget.details,
        "mobile": _mobController.text,
        "address": _addressController.text,
        "date_time": dt
      });
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc('OyyVyUTow1dKiARbGjliFRGTuMt2')
          .collection("user_bookings")
          .doc()
          .set({
        "name": _nameController.text,
        "image": widget.image,
        "title": widget.title,
        "price": widget.price,
        "details": widget.details,
        "mobile": _mobController.text,
        "address": _addressController.text,
        "date_time": dt
      });
      
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Your service is booked"),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Your Service"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Form(
          key: _bookKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Book your service now.",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    "We are providing best services in all over city.",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      hintText: "Enter Name",
                    ),
                    validator: (value) {
                      if (_mobController.text.trim().isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _mobController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      hintText: "Enter mobile no.",
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (_mobController.text.trim().isEmpty ||
                          _mobController.text.length != 10) {
                        return "Enter valid no.";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      hintText: "Enter Address",
                    ),
                    validator: (value) {
                      if (_addressController.text.trim().isEmpty ||
                          _addressController.text.length < 25) {
                        return "Enter detailed address";
                      }
                      return null;
                    },
                    maxLength: 1000,
                    maxLines: 10,
                    controller: _addressController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _book(context);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orange)),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Pay"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
