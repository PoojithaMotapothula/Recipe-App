import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class Veg_RecipeDetails extends StatefulWidget {
  final Map<String, dynamic> recipeData;

  
  Veg_RecipeDetails({required this.recipeData});

  @override
  State<Veg_RecipeDetails> createState() => _Veg_RecipeDetailsState();
}

class _Veg_RecipeDetailsState extends State<Veg_RecipeDetails> {
   bool isFavorite = false;
  void _toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      CollectionReference favoritesDataCollection =
          userDocRef.collection('favoritesdata');
      QuerySnapshot querySnapshot = await favoritesDataCollection
          .where('title', isEqualTo: widget.recipeData['title'])
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        await favoritesDataCollection.add({
          'title': widget.recipeData['title'],
          'image': widget.recipeData['image'],
          'time': widget.recipeData['time'],
          'serves': widget.recipeData['serves'],
        });

        Fluttertoast.showToast(
          msg: 'Recipe added to favorites!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          isFavorite = true;
        });
      } 
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.recipeData['title'] ?? 'Recipe Details',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Image.network(
                  widget.recipeData['image'] ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.recipeData['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          // color: Colors.black,
                          color: Colors.amber,
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 22,
                          ),
                          Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.recipeData['Calories'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'DMSerifDisplay',
                                      color: Colors.amber),
                                ),
                                const Center(
                                  child: Text(
                                    "Calories",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'DMSerifDisplay',
                                        color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.recipeData['Protiens'] ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DMSerifDisplay',
                                    color: Colors.amber),
                              ),
                              const Center(
                                child: Text(
                                  "Proteins",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'DMSerifDisplay',
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.recipeData['Carbohydrate'] ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DMSerifDisplay',
                                    // color: Colors.amber
                                    color: Colors.amber),
                              ),
                              const Center(
                                child: Text(
                                  "Carbs",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'DMSerifDisplay',
                                      // color: Colors.amber
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.recipeData['Fats'] ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DMSerifDisplay',
                                    color: Colors.amber),
                              ),
                              const Center(
                                child: Text(
                                  "Fats",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'DMSerifDisplay',
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.alarm,
                                color: Colors.teal[400], size: 22),
                            const SizedBox(width: 8),
                            Text(
                              widget.recipeData['time'] ?? '',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'DMSans',
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Row(
                          children: [
                            Icon(Icons.group_outlined,
                                color: Colors.teal[400], size: 24),
                            const SizedBox(width: 5),
                            Text(
                              widget.recipeData['serves'] ?? '' 'people',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'DMSans',
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 55,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.share,
                                  color: Colors.teal[400], size: 24),
                              onPressed: () {
                                Share.share(
                                    "https://play.google.com/store/apps/details?id=com.synergyuniversal.receptoria1&pcampaignid=web_share");
                              },
                            ),
                            const SizedBox(width: 7),
                            Text(
                              'Share',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                const TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: 'Ingredients',
                    ),
                    Tab(text: 'Process'),
                  ],
                ),
              ),
              pinned: true,
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  // Content for Tab 1
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Text(
                          widget.recipeData['ingredients'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content for Tab 2
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          const Text(
                            'Step-1',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'PlaypenSans',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.recipeData['step-1'] ?? '',
                            // textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            'Step-2',
                            style: TextStyle(
                                fontFamily: 'PlaypenSans',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.recipeData['step-2'] ?? '',
                            // textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            'Step-3',
                            style: TextStyle(
                                fontFamily: 'PlaypenSans',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.recipeData['step-3'] ?? '',
                            // textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            'Step-4',
                            style: TextStyle(
                                fontFamily: 'PlaypenSans',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.recipeData['step-4'] ?? '',
                            // textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            'Step-5',
                            style: TextStyle(
                                fontFamily: 'PlaypenSans',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.recipeData['step-5'] ?? '',
                            // textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            'Step-6',
                            style: TextStyle(
                                fontFamily: 'PlaypenSans',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.recipeData['step-6'] ?? '',
                            // textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
