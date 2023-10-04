// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:voloc/views/common_widget/statuswise_detail.dart';

class StatusBookingWidget extends StatelessWidget {
  const StatusBookingWidget(
      {super.key,
      required this.price,
      required this.details,
      required this.image,
      required this.title,
      this.name,
      this.number,
      this.address,
      this.date,
      required this.deleteData,
      required this.bookingStatus});

  final price;
  final bookingStatus;
  final details;
  final image;
  final title;
  final name;
  final number;
  final date;
  final address;
  final deleteData;

  @override
  Widget build(BuildContext context) {
    if (bookingStatus == "confirm") {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(90, 184, 185, 185),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 180,
        width: double.maxFinite,
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '$title',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingDetailsStatus(
                          price: price,
                          image: image,
                          details: details,
                          title: title,
                          name: name,
                          number: number,
                          address: address,
                          date: date,
                          deleteData: deleteData,
                          bookingStatus: bookingStatus,
                        ),
                      ),
                    ),
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange,
                        ),
                        child: const Text(' DETAILS  '),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.greenAccent,
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            ' CONFIRMED ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(
                        '$image',
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ],
        ),
      );
    } else if (bookingStatus == "cancel") {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(90, 184, 185, 185),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 180,
        width: double.maxFinite,
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '$title',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingDetailsStatus(
                          price: price,
                          image: image,
                          details: details,
                          title: title,
                          name: name,
                          number: number,
                          address: address,
                          date: date,
                          deleteData: deleteData,
                          bookingStatus: bookingStatus,
                        ),
                      ),
                    ),
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange,
                        ),
                        child: const Text(' DETAILS  '),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.redAccent,
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            ' CANCELLED ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                      '$image',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (bookingStatus == "complete") {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(90, 184, 185, 185),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 180,
        width: double.maxFinite,
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '$title',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingDetailsStatus(
                          price: price,
                          image: image,
                          details: details,
                          title: title,
                          name: name,
                          number: number,
                          address: address,
                          date: date,
                          deleteData: deleteData,
                          bookingStatus: bookingStatus,
                        ),
                      ),
                    ),
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange,
                        ),
                        child: const Text(' DETAILS  '),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            ' COMPLETED ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                      '$image',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Text("nothing");
    }
  }
}
