import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voloc/data/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try{
        final user = FirebaseAuth.instance.currentUser!;
        final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      
      UserModel userModel = UserModel.fromSnapshot(userData);
      emit(state.copyWith(
          userModel: userModel));
      }catch(e){
        debugPrint(e.toString());
        emit(state.copyWith(error: e.toString()));
      }finally{
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
