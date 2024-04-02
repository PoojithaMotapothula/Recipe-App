// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:receptoria1/pages/details/tips_details.dart';

// class CookingTip {
//   final String tipNumber;
//   final String tipHeading;
//   final String tipDescription;
//   final String image;

//   CookingTip({
//     required this.tipNumber,
//     required this.tipHeading,
//     required this.tipDescription,
//     required this.image,
//   });
// }

// class CookingTipsPage extends StatefulWidget {
//   @override
//   _CookingTipsPageState createState() => _CookingTipsPageState();
// }

// class _CookingTipsPageState extends State<CookingTipsPage> {
//   final List<CookingTip> _tips = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadTips();
//   }

//   void _loadTips() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('cooking_tips')
//         .orderBy('tipNumber')
//         .limit(15)
//         .get();
//     setState(() {
//       _tips.clear();
//       _tips.addAll(
//         querySnapshot.docs.map(
//           (doc) => CookingTip(
//               tipNumber: doc['tipNumber'],
//               tipHeading: doc['tipHeading'],
//               tipDescription: doc['tipDescription'],
//               image: doc['image']),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'Cooking Tips',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 22,
//             fontFamily: 'DMSans',
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: _tips.length,
//         itemBuilder: (context, index) {
//           return Card(
//             color: Colors.white,
//             child: ListTile(
//               title: Row(
//                 children: [
//                   Text(
//                     ' ${_tips[index].tipHeading.split('').take(35).join('')}',
//                     style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontFamily: 'Mulish',
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TipScreen(tip: _tips[index]),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:receptoria1/pages/details/tips_details.dart';

class CookingTip {
  final String tipNumber;
  final String tipHeading;
  final String tipDescription;
  final String image;

  CookingTip({
    required this.tipNumber,
    required this.tipHeading,
    required this.tipDescription,
    required this.image,
  });
}

class CookingTipsPage extends StatefulWidget {
  @override
  _CookingTipsPageState createState() => _CookingTipsPageState();
}

class _CookingTipsPageState extends State<CookingTipsPage> {
  final List<CookingTip> _tips = [];

  @override
  void initState() {
    super.initState();
    _loadTips();
  }

  void _loadTips() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cooking_tips')
        .orderBy('tipNumber')
        .limit(15)
        .get();
    setState(() {
      _tips.clear();
      _tips.addAll(
        querySnapshot.docs.map(
          (doc) => CookingTip(
              tipNumber: doc['tipNumber'],
              tipHeading: doc['tipHeading'],
              tipDescription: doc['tipDescription'],
              image: doc['image']),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Cooking Tips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'DMSans',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text(
                      ' ${_tips[index].tipHeading.split('').take(35).join('')}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TipScreen(tip: _tips[index]),
                    ),
                  );
                },
              ),
              Divider(), // Add a divider between tips
            ],
          );
        },
      ),
    );
  }
}
