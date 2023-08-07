import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';

// ignore: constant_identifier_names
enum InternetState{Initial, Lost, Connected}

class InternetCubit extends Cubit<InternetState> {
  final _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetCubit() : super(InternetState.Initial){
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        emit(InternetState.Connected);
      }else if(result != ConnectivityResult.mobile || result != ConnectivityResult.wifi){
        emit(InternetState.Lost);
      }else{
        emit(InternetState.Initial);
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}