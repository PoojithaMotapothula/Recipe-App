import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:receptoria1/pages/flashscreens/splash.dart';
import 'package:receptoria1/pages/navbar/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth if not already imported

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _buildHomeScreen(),
    );
  }

Widget _buildHomeScreen() {
  switch (_connectionStatus) {
    case ConnectivityResult.none:
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 300,
                ),
                Center(
                  child: Image.asset(
                    'assets/home/no-internet.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'You are offline. Please check your internet connection.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    case ConnectivityResult.mobile:
    case ConnectivityResult.wifi:
      if (_alreadyLoggedIn()) {
        return Dashboard();
      } else {
        return SplashScreen();
      }
    default:
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/home/no-internet.png', height: 100, width: 100),
            const Center(
              child: Text(
                'Failed to determine connectivity status.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
  }
}

  bool _alreadyLoggedIn() {
    // Replace this logic with your actual authentication check
    // For example, if you are using Firebase Authentication:
    return FirebaseAuth.instance.currentUser != null;
  }
}
