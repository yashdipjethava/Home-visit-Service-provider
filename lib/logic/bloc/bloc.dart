// //This is dummy file and will be deletedelse if(state.userModel == null){
            
//             return Column(
//             children: [
//               Container(
//                 height: 80,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: kColorScheme.onSecondary,
//                   //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.width * 0.06,
//                       left: MediaQuery.of(context).size.width * 0.030,
//                       right: MediaQuery.of(context).size.width * 0.030),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             if (_key.currentState!.isDrawerOpen) {
//                               _key.currentState!.closeDrawer();
//                             } else {
//                               _key.currentState!.openDrawer();
//                             }
//                           },
//                           child: const Icon(
//                             Icons.menu,
//                             color: Colors.white,
//                           )),
//                       const Text(
//                         'Log Out',
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                       GestureDetector(
//                           onTap: () {
//                             _signout();
//                             if (FirebaseAuth.instance.currentUser == null) {
//                               Navigator.pushReplacement(context,
//                                   MaterialPageRoute(
//                                 builder: (context) {
//                                   return const LogInScreen();
//                                 },
//                               ));
//                             } else {}
//                           },
//                           child: const Icon(
//                             Icons.logout,
//                             color: Colors.white,
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.30),
//                 child: Column(
//                   children: [
//                     Text(
//                       name.toString(),
//                       style: const TextStyle(fontSize: 25, color: Colors.black),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       gmail.toString(),
//                       style: const TextStyle(fontSize: 20, color: Colors.black),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(photo.toString()),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//           }