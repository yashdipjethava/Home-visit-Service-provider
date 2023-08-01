import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voloc/core/themes/app_theme.dart';
import 'package:voloc/data/models/models.dart';
import 'package:voloc/views/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey();

   _signout() async{
        await FirebaseAuth.instance.signOut();
       GoogleSignIn().signOut();
   }

  @override
  Widget build(BuildContext context) {
     var name  = FirebaseAuth.instance.currentUser!.displayName;
     var gmail = FirebaseAuth.instance.currentUser!.email;
     var photo = FirebaseAuth.instance.currentUser!.photoURL;

    return Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: kColorScheme.onSecondary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: ( BuildContext context, int index) {
                return ListTile(
                  title: Text(list[index]['title'],style: TextStyle(fontSize: 17,color: Colors.white),),
                  leading: Icon(list[index]['icon']),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return list[index]['page'];
                    },));
                  },
                );
              },),
          ),
        ),
        body: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kColorScheme.onSecondary,
                  //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.06,left: MediaQuery.of(context).size.width*0.030,right: MediaQuery.of(context).size.width*0.030),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            if(_key.currentState!.isDrawerOpen){
                              _key.currentState!.closeDrawer();
                            }else{
                              _key.currentState!.openDrawer();
                            }
                          },
                          child: const Icon(Icons.menu,color: Colors.white,)
                      ),
                      const Text('Log Out',style: TextStyle(color: Colors.white,fontSize: 20),),
                      GestureDetector(
                          onTap: (){
                            _signout();
                            if(FirebaseAuth.instance.currentUser == null ){
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return const LogInScreen();
                              },));
                            }else{
                            }
                          },
                          child:const  Icon(Icons.logout,color: Colors.white,)
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.30),
                child: Column(
                  children: [
                    Text('$name',style: TextStyle(fontSize: 25,color: Colors.black),),
                    SizedBox(height: 20,),
                    Text('$gmail',style: TextStyle(fontSize: 20,color: Colors.black),),
                    SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('$photo'),
                    ),
                  ],
                ),
              ),

            ],
            ),
        );
  }
}