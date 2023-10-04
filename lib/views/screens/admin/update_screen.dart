import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UpdateScreen extends StatefulWidget {
  final String documentID;
  final Map<String, dynamic> records;

  UpdateScreen({required this.documentID, required this.records});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  bool isLoading = false;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailsController = TextEditingController();
  File? _selectImage;

  final _dataKey = GlobalKey<FormState>();

  Future<void> _downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/temp_image.jpg');
        await tempFile.writeAsBytes(bytes);
        setState(() {
          _selectImage = tempFile;
        });
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.records['title'];
    _priceController.text = widget.records['price'];
    _detailsController.text = widget.records['details'];

    _downloadImage(widget.records['image']);
  }

  Future<void> _updateData() async {
    if (_dataKey.currentState!.validate() && _selectImage != null) {
      setState(() {
        isLoading = true;
      });

      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('service_images')
            .child('${_selectImage!.path}.jpg');

        await storageRef.putFile(_selectImage!);

        final imageUrl = await storageRef.getDownloadURL();

        final updatedData = {
          "title": _titleController.text,
          "image": imageUrl,
          "price": _priceController.text,
          "details": _detailsController.text
        };

        final documentReference = FirebaseFirestore.instance
            .collection('services')
            .doc(widget.documentID);

        await documentReference.update(updatedData);

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Data Updated')));
        Navigator.pop(context);

        setState(() {
          isLoading = false;
        });
      } catch (ex) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ex.toString())));

        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: _selectImage == null
              ? const Text('Choose Image')
              : const Text('Failed to update')));

      setState(() {
        isLoading = false;
      });
    }
  }

  _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    setState(() {
      _selectImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _dataKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'Title',
                    style: TextStyle(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 4),
                  ),
                ),
                validator: (value) {
                  if (_titleController.text
                      .trim()
                      .isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
                controller: _titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  alignment: Alignment.center,
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _selectImage == null
                      ? const Center(
                    child: Icon(
                      Icons.camera,
                      color: Colors.black,
                      size: 50,
                    ),
                  )
                      : Image.file(
                    _selectImage!,
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text(
                      'Price',
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 4),
                    ),
                  ),
                  validator: (value) {
                    if (_priceController.text
                        .trim()
                        .isEmpty) {
                      return 'Enter price';
                    }
                    return null;
                  },
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'Details',
                    style: TextStyle(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 4),
                  ),
                ),
                validator: (value) {
                  if (_detailsController.text
                      .trim()
                      .isEmpty ||
                      _detailsController.text
                          .trim()
                          .length < 20) {
                    return 'Enter more details';
                  }
                  return null;
                },
                controller: _detailsController,
                maxLength: 10000,
                maxLines: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: _updateData,
                  child: isLoading
                      ? const Center(
                      child: CircularProgressIndicator())
                      : const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }}