import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
    final String email;
    final String image;
    final String number;
    final String username;

    UserModel({
        required this.email,
        required this.image,
        required this.number,
        required this.username,
    });

    UserModel copyWith({
        String? email,
        String? image,
        String? number,
        String? username,
    }) => 
        UserModel(
            email: email ?? this.email,
            image: image ?? this.image,
            number: number ?? this.number,
            username: username ?? this.username,
        );

    UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot)
        
      : email = documentSnapshot.data()?['email'],
        username = documentSnapshot.data()?['username'],
        number = documentSnapshot.data()?['number'],
        image = documentSnapshot.data()?['image'];
}
