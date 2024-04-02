import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receptoria1/pages/catalogue/beverages.dart';
import 'package:receptoria1/pages/catalogue/desserts.dart';
import 'package:receptoria1/pages/catalogue/nonveg.dart';
import 'package:receptoria1/pages/catalogue/veg.dart';
import 'package:receptoria1/pages/details/populardetails.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? username;
  String? useruid;
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    // String uid = user!.uid;

    if (user != null) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      try {
        DocumentSnapshot userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          setState(() {
            username = userData['username'];
            useruid = user.uid;
          });
          print('User ID: ${user.uid}');
          print('Username: ${userData['username']}');
          print('Email: ${user.email}');
        } else {
          print('User data not found.');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('User not signed in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/home/pro.png',
                      width: 30,
                      height: 30,
                      scale: 8,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Hello, $username',
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'DMSans-Variable',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Choose the best dish for you',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  letterSpacing: 0.5,
                  fontFamily: 'DMSans-Variable',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [const BoxShadow(blurRadius: 2.0)],
                ),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    icon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/home/filter.png',
                        color: Colors.amber,
                        scale: 22,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 180.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 330.0,
                      decoration: BoxDecoration(
                        color: Colors.teal[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 35.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Find recipies based\non what you already\nhave at home',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Mulish'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Let's Try -->",
                                  style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[300],
                                      fontFamily: 'DMSans'),
                                )
                              ],
                            ),
                          ),
                          Image.asset('assets/home/banner-1.png',
                              height: 150, width: 150),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 340.0,
                      decoration: BoxDecoration(
                        color: Colors.teal[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 35.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Turn your kitchen\ninto a culinary haven\nwith our recipies',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Mulish'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Let's Try -->",
                                  style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[300],
                                      fontFamily: 'DMSans'),
                                )
                              ],
                            ),
                          ),
                          Image.asset('assets/home/banner-2.png',
                              height: 150, width: 150),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 350.0,
                      decoration: BoxDecoration(
                        color: Colors.teal[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 35.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Turns ordinary ingredients\ninto extraordinary\ncreations',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Mulish'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Let's Try -->",
                                  style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[300],
                                      fontFamily: 'DMSans'),
                                )
                              ],
                            ),
                          ),
                          Image.asset('assets/home/banner-3.png',
                              height: 120, width: 120),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 360.0,
                      decoration: BoxDecoration(
                        color: Colors.teal[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 35.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Embark on a flavor-\nfilled journey from\nyour own kitchen',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Mulish'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Let's Try -->",
                                  style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[300],
                                      fontFamily: 'DMSans'),
                                )
                              ],
                            ),
                          ),
                          Image.asset('assets/home/banner-4.png',
                              height: 180, width: 180),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  letterSpacing: 1,
                  fontFamily: 'DMSans-Variable',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Veg()),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/home/v.png',
                                width: 100,
                                height: 100,
                              ),
                              const Text(
                                "Veg",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'DMSans-Variable',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NonVeg()),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/home/n.png',
                                scale: 4,
                              ),
                              const Text(
                                "Non-Veg",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'DMSans-Variable',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Desserts()),
                            );
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                'assets/home/d.png',
                                scale: 4,
                              ),
                              const Text(
                                "Desserts",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'DMSans-Variable',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Beverages()),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/home/j.png',
                                width: 100,
                                height: 100,
                              ),
                              const Text(
                                "Beverages",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'DMSans-Variable',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Popular Recipies",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      letterSpacing: 1,
                      fontFamily: 'DMSans-Variable',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.teal[300],
                        fontSize: 16,
                        fontFamily: 'DMSans-variable',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('foods')
                      .doc('Popular Recipies')
                      .collection('recipes')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var recipeData = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          var recipeId = snapshot.data!.docs[index].id;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetails(recipeId: recipeId),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.grey,
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                recipeData['image']),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            recipeData['title'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: 'DMSans-Variable',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.alarm,
                                                  color: Colors.teal[300],
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  recipeData['time'],
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'DMSans-Variable',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.circle_rounded,
                                                  color: Colors.teal[300],
                                                  size: 13,
                                                ),
                                                const SizedBox(width: 8),
                                                const Text(
                                                  "Medium",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'DMSans-Variable',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.teal[300],
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  recipeData['serves'],
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'DMSans-Variable',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Text('No recipes found.');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
