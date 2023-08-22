
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailsController = TextEditingController();
  File? _selectImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text(
                    'Title',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                controller: _titleController,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  final image = await ImagePicker().pickImage(source: ImageSource.camera);

                  if(image == null){
                    return;
                  }
                  setState(() {
                    _selectImage = File(image.path);
                  });
                },
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
                  child: _selectImage == null ? const Center(child: Icon(Icons.camera,color: Colors.black,size: 50,),): Image.file(_selectImage!,fit: BoxFit.fill,height: double.infinity,width: double.infinity,),
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text(
                    'Price',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text(
                    'Details',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                controller: _detailsController,
                maxLength: 1000,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: () async {
                final storageRef = FirebaseStorage.instance
            .ref()
            .child('service_images')
            .child('${_selectImage!.path}.jpg');

            await storageRef.putFile(_selectImage!);

            final imageUrl = await storageRef.getDownloadURL();
                FirebaseFirestore.instance.collection('services').doc().set(
                  {"title" : _titleController.text,
                  "image":imageUrl,
                  "price":_priceController.text,
                  "details":_detailsController.text
                  }

                );
              }, child: const Text('ADD'))
            ],
          )),
    );
  }
}
