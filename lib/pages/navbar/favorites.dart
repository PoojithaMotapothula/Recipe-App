import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share/share.dart';
import 'package:lottie/lottie.dart';

class FavoriteRecipesList extends StatefulWidget {
  @override
  _FavoriteRecipesListState createState() => _FavoriteRecipesListState();
}

class _FavoriteRecipesListState extends State<FavoriteRecipesList> {
  String? useruid;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      try {
        DocumentSnapshot userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          setState(() {
            useruid = user.uid;
          });
          print('User ID: ${user.uid}');
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Favorites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'DMSans',
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Recipes',
              ),
              Tab(text: 'Tips'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Recipes Tab
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(useruid)
                  .collection('favoritesdata')
                  .snapshots(),
              builder: (context, snapshot) {
                print('StreamBuilder triggered!');
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Lottie.asset('assets/icons/empt-fav.json',
                            height: 200, width: 200),
                        const Text(
                          'No favorite recipes yet!',
                          style: TextStyle(
                              fontFamily: 'Mulish-Italic-VariableFont',
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var recipeData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          // Remove the item from favorites when it is dismissed
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(useruid)
                              .collection('favoritesdata')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        child: FavoriteRecipeCard(
                          title: recipeData['title'] ?? '',
                          imageUrl: recipeData['image'] ?? '',
                          time: recipeData['time'] ?? '',
                          serves: recipeData['serves'] ?? '',
                        ),
                      );
                    },
                  );
                }
              },
            ),
            // Tips Tab
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(useruid)
                  .collection('favoritetips')
                  .snapshots(),
              builder: (context, snapshot) {
                print('StreamBuilder triggered!');
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Lottie.asset('assets/icons/empt-fav.json',
                            height: 200, width: 200),
                        const Text(
                          'No favorite tips yet!',
                          style: TextStyle(
                              fontFamily: 'Mulish-Italic-VariableFont',
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var recipeData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          // Remove the item from favorites when it is dismissed
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(useruid)
                              .collection('favoritetips')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        child: FavoriteTipCard(
                          title: recipeData['title'] ?? '',
                          imageUrl: recipeData['image'] ?? '',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteRecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String time;
  final String serves;

  FavoriteRecipeCard({
    required this.title,
    required this.imageUrl,
    required this.time,
    required this.serves,
  });

  @override
  Widget build(BuildContext context) {
    double _iconSize() {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth > 600 ? 30 : 24;
    }

    double _fontSize() {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth > 600 ? 20 : 18;
    }

    double _sizedBoxWidth() {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth > 600 ? 65 : 45;
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 400, // Set a specific width for the Image widget
            child: Image.network(
              imageUrl,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
              const SizedBox(
                width: 150,
              ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.red, size: _iconSize()),
                onPressed: () {
                  Share.share(
                    "https://play.google.com/store/apps/details?id=com.synergyuniversal.receptoria1&pcampaignid=web_share",
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoriteTipCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  FavoriteTipCard({
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    double _iconSize() {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth > 600 ? 30 : 24;
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 400, // Set a specific width for the Image widget
            child: Image.network(
              imageUrl,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.red, size: _iconSize()),
                onPressed: () {
                  Share.share(
                    "Share this tip: $title",
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
