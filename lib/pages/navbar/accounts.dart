import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receptoria1/pages/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String? username;
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user!.uid);
        final userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;

          setState(() {
            username = userData['username'];
          });

          print('User ID: ${user!.uid}');
          print('Username: $username');
          print('Email: ${user!.email}');
        } else {
          print('User data not found.');
        }
      } else {
        print('User not signed in.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const Text(
                'Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'DMSans',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  ClipOval(
                    child: Image.asset(
                      'assets/home/pro.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 85.0),
                        child: Text(
                          '$username',
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'DMSans-Variable',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${user?.email}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'DMSans-Variable',
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(), // Added divider line
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Privacy",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 130.0),
                      child: Text("Know about Tems & Conditions"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  openAppSettings();
                },
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 120.0),
                      child: Text("Manage how your data is handled"),
                    )
                  ],
                ),
              ),
              const Divider(), // Added divider line
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  _showDeveloperDetailsDialog(context);
                },
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Help",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 180.0),
                      child: Text("Get help within seconds "),
                    )
                  ],
                ),
              ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "LogOut",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "DMSans",
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 5,
                      ),
                    ),
                    const Icon(Icons.logout)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeveloperDetailsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Developer Details"),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Developer: Poojitha Motapothula"),
              SizedBox(height: 10),
              Text("Contact: iam.poojithamotapothula@gmail.com"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}

_launchURL() async {
  const url =
      'https://www.termsfeed.com/live/7055acb4-8dad-4fa2-9ecc-50116b2e4098';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
