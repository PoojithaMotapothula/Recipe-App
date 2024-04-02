import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Display extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Data'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('foods')
            .doc('Veg')
            .collection('recipes')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Widget> recipeWidgets = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            return Card(
              child: GridTile(
                child: ListTile(
                  title: Text(data['title'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(data['ingredients'] ?? ''),
                      if (data['image'] != null)
                        Image.network(
                          data['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                  // Add more fields as needed
                ),
              ),
            );
          }).toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns you want
              crossAxisSpacing: 8.0, // Set the spacing between columns
              mainAxisSpacing: 8.0, // Set the spacing between rows
            ),
            itemCount: recipeWidgets.length,
            itemBuilder: (context, index) {
              return recipeWidgets[index];
            },
          );
        },
      ),
    );
  }
}
