import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:receptoria1/pages/navbar/dashboard.dart';
import 'package:receptoria1/pages/details/nonveg.details.dart';

class NonVeg extends StatefulWidget {
  const NonVeg({Key? key}) : super(key: key);

  @override
  State<NonVeg> createState() => _NonVegState();
}

class _NonVegState extends State<NonVeg> {
  void onIconPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onIconPressed,
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 58),
                const Text(
                  'Non-Veg',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans-Variable',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('foods')
                  .doc('Non-Veg')
                  .collection('recipes')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                print('Builder function called.');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                List<Widget> recipeWidgets = snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      onCardTapped(data);
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.48,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(data['image'] ?? ''),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['title'] ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontFamily: 'DMSans-Variable',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/home/calories.png',
                                        width: 25,
                                        height: 25,
                                        color: Colors.teal[400],
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        data['Calories'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'DMSans-Variable',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.teal[400],
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        data['time'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'DMSans-Variable',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.group,
                                        color: Colors.teal[400],
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        data['serves'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'DMSans-Variable',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.3),
                  ),
                  itemCount: recipeWidgets.length,
                  itemBuilder: (context, index) {
                    return recipeWidgets[index];
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onCardTapped(Map<String, dynamic> recipeData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NonVeg_RecipeDetails(recipeData: recipeData),
      ),
    );
  }
}
