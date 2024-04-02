// // import 'package:flutter/material.dart';
// // import 'package:receptoria1/pages/navbar/tips.dart';

// // class TipScreen extends StatelessWidget {
// //   final CookingTip tip;
// //   bool isFavorite = false;

// //   TipScreen({required this.tip});
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(
// //               height: 30,
// //             ),
// //             Row(
// //               children: [
// //                 IconButton(
// //                   onPressed: () {
// //                     Navigator.pop(context);
// //                   },
// //                   icon: Icon(Icons.arrow_back, size: 30),
// //                 ),
// //                 SizedBox(
// //                   width: 250,
// //                 ),
// //                 Expanded(
// //                   child: IconButton(
// //                     icon: Icon(
// //                       isFavorite
// //                           ? Icons.favorite
// //                           : Icons.favorite_border_outlined,
// //                       size: 25,
// //                       color: isFavorite ? Colors.red : null,
// //                     ),
// //                     onPressed: () {
                     
// //                     },
// //                   ),
// //                 )
// //               ],
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               tip.tipHeading,
// //               style: const TextStyle(
// //                 fontFamily: 'DMSans',
// //                 fontSize: 26,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 30,
// //             ),
// //             Image.network(
// //               tip.image,
// //               height: 200,
// //               width: double.infinity,
// //               fit: BoxFit.cover,
// //             ),
// //             const SizedBox(height: 20),
// //             Text(
// //               tip.tipDescription,
// //               style: const TextStyle(
// //                 fontSize: 16,
// //                 fontFamily: 'DMSans',
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }




// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database
// import 'package:receptoria1/pages/navbar/tips.dart';

// class TipScreen extends StatelessWidget {
//   final CookingTip tip;
//   final DatabaseReference _favoritesRef = FirebaseDatabase.instance.reference().child('users'); // Reference to Firebase database

//   TipScreen({required this.tip});

//   void _toggleFavorite() {
//     // Toggle the favorite status
//     isFavorite = !isFavorite;
    
//     // If it's now a favorite, add it to Firebase, otherwise remove it
//     if (isFavorite) {
//       _favoritesRef.child('userId').child('favorites').push().set({
//         'tipHeading': tip.tipHeading,
//         'imageUrl': tip.image,
//         'tipDescription': tip.tipDescription,
//       });
//     } else {
//       // Remove from Firebase (Not implemented here, but you'd need to identify the specific favorite to remove)
//     }
//   }

//   bool isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.arrow_back, size: 30),
//                 ),
//                 SizedBox(
//                   width: 250,
//                 ),
//                 Expanded(
//                   child: IconButton(
//                     icon: Icon(
//                       isFavorite
//                           ? Icons.favorite
//                           : Icons.favorite_border_outlined,
//                       size: 25,
//                       color: isFavorite ? Colors.red : null,
//                     ),
//                     onPressed: _toggleFavorite, // Call _toggleFavorite method when the button is pressed
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               tip.tipHeading,
//               style: const TextStyle(
//                 fontFamily: 'DMSans',
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Image.network(
//               tip.image,
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               tip.tipDescription,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'DMSans',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
// import 'package:receptoria1/pages/navbar/tips.dart';

// class TipScreen extends StatelessWidget {
//   final CookingTip tip;
//   bool isFavorite = false;

//   TipScreen({required this.tip});

//   // Function to add tip to favorites in Firestore
//   void addToFavorites() {
//     FirebaseFirestore.instance.collection('favorites').add({
//       'tipHeading': tip.tipHeading,
//       'image': tip.image,
//     }).then((_) {
//       // Set isFavorite to true after successfully adding to favorites
//       isFavorite = true;
//     }).catchError((error) {
//       // Handle errors here
//       print("Error adding to favorites: $error");
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.arrow_back, size: 30),
//                 ),
//                 SizedBox(
//                   width: 250,
//                 ),
//                 Expanded(
//                   child: IconButton(
//                     icon: Icon(
//                       isFavorite
//                           ? Icons.favorite
//                           : Icons.favorite_border_outlined,
//                       size: 25,
//                       color: isFavorite ? Colors.red : null,
//                     ),
//                     onPressed: () {
//                       // Call addToFavorites function when favorite button is pressed
//                       addToFavorites();
//                     },
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               tip.tipHeading,
//               style: const TextStyle(
//                 fontFamily: 'DMSans',
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Image.network(
//               tip.image,
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               tip.tipDescription,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'DMSans',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:receptoria1/pages/navbar/tips.dart';

class TipScreen extends StatefulWidget {
  final CookingTip tip;

  TipScreen({required this.tip});

  @override
  _TipScreenState createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, size: 30),
                ),
                SizedBox(
                  width: 250,
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 25,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      _toggleFavorite();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.tip.tipHeading,
              style: const TextStyle(
                fontFamily: 'DMSans',
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.network(
              widget.tip.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              widget.tip.tipDescription,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'DMSans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      CollectionReference favoritesDataCollection =
          userDocRef.collection('favoritetips');
      QuerySnapshot querySnapshot = await favoritesDataCollection
          .where('title', isEqualTo: widget.tip.tipHeading)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        await favoritesDataCollection.add({
          'title': widget.tip.tipHeading,
          'image': widget.tip.image,
          // Add other fields you want to save
        });

        Fluttertoast.showToast(
          msg: 'Tip added to favorites!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          isFavorite = true;
        });
      }
    }
  }
}
