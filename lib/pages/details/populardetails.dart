import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class RecipeDetails extends StatelessWidget {
  final String recipeId;

  RecipeDetails({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('foods')
            .doc('Popular Recipies')
            .collection('recipes')
            .doc(recipeId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData && snapshot.data!.exists) {
            var recipeData = snapshot.data!.data() as Map<String, dynamic>;

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
                        background: Image.network(
                          recipeData['image'] ?? '',
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
                                  recipeData['title'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                const Icon(
                                  Icons.favorite_border_outlined,
                                  size: 25,
                                )
                              ],
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
                                      recipeData['time'] ?? '',
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
                                      recipeData['serves'] ?? '' 'people',
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
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    recipeData['ingredients'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Content for Tab 2
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                children: [
                                  Text(
                                    recipeData['process'] ?? '',
                                    textAlign: TextAlign.justify,
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
          } else {
            return Text('Recipe not found.');
          }
        },
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
