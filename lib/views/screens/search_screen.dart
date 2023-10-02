import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../common_widget/jobWidget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();
  List<Map<String, dynamic>> allItems = [];
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  // Fetch data from Firestore
  Future<void> fetchDataFromFirestore() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('services').get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          allItems = querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
          // Initialize filteredItems with allItems initially
          filteredItems = allItems;
        });
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      try {
        filteredItems = allItems
            .where((item) =>
                item['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      } catch (e) {
        print('Error filtering data: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search,color: Colors.orange,),
                    suffixIcon: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            editingController.clear();
                            filteredItems = allItems;
                          });
                        },
                        icon: const Icon(Icons.cancel,color: Colors.orange,),
                        label: const Text('')),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final record = filteredItems[index];
        
                    // Create a JobWidget only for the matching items
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: JobWidget(
                        title: record['title'],
                        details: record['details'],
                        image: record['image'],
                        price: record['price'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
