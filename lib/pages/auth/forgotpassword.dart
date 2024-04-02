import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:receptoria1/pages/auth/login.dart';
import 'package:receptoria1/pages/auth/success.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  String? newPassword;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double availableHeight =
        screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: availableHeight,
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: availableHeight * 0.05,
              ),
              Center(
                child: Lottie.asset('assets/icons/password.json',
                    height: 300, width: 300),
                // child: Lottie.network('https://iconscout.com/lottie-animation/cooking-food-pan-7851818',
                //     height: 300, width: 300),
              ),
              SizedBox(
                height: availableHeight * 0.05,
              ),
              Text(
                'Enter your email address to reset your password',
                style: TextStyle(
                    fontSize: availableHeight * 0.025,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: availableHeight * 0.03),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email contains',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an Email';
                  } else if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: availableHeight * 0.05),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Please enter your email address.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      _sendPasswordResetEmail(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordResetSuccessScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[300],
                    padding: EdgeInsets.symmetric(
                      horizontal: availableHeight * 0.10,
                      vertical: availableHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.teal[300]!),
                    ),
                  ),
                ),
              ),
              SizedBox(height: availableHeight * 0.03),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Remember your Password? ",
                    style: TextStyle(fontFamily: 'DMSans', color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    String email = _emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: Text(
              'A password reset email has been sent to $email. Please check your inbox and follow the instructions to reset your password.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // Add a listener to FirebaseAuth to detect when the user has changed their password
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          if (newPassword != null) {
            _updatePasswordInFirestore(email, newPassword!);
          } else {
            print('New password is null');
          }
        }
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Failed to send password reset email. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _updatePasswordInFirestore(
      String email, String newPassword) async {
    try {
      // Retrieve user ID from Firestore using email
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      String userId = userSnapshot.id;

      // Update password in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'password': newPassword,
      });

      // Show success message
      print('Password updated in Firestore successfully');
    } catch (e) {
      // Handle error
      print('Failed to update password in Firestore: $e');
    }
  }
}
