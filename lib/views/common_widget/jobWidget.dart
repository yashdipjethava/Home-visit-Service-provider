import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:voloc/views/common_widget/jobDetailWidget.dart';

class JobWidget extends StatelessWidget {
  const JobWidget(
      {super.key,
      required this.price,
      required this.details,
      required this.image,
      required this.title,
      this.revser,});

  final price;
  final details;
  final image;
  final title;
  final revser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(90, 156, 156, 195),
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
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        '$title',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '₹$price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailWidget(
                        price: price,
                        image: image,
                        details: details,
                        title: title,
                        revser: revser,
                      ),
                    ),
                  ),
                  child: Card(
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange,
                      ),
                      child: const Text(' DETAILS  '),
                    ),
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
                  child: Hero(
                    tag: image,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(
                        '$image',
                      ),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
