// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/gestures.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:receptoria1/pages/backend/firebase_user_auth.dart';
// // import 'package:receptoria1/pages/auth/signup.dart';
// // import 'package:receptoria1/pages/navbar/dashboard.dart';

// // class Login extends StatefulWidget {
// //   const Login({Key? key});

// //   @override
// //   State<Login> createState() => _LoginState();
// // }

// // class _LoginState extends State<Login> {
// //   bool _isObscure = true;
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   final FirebaseAuthService _auth = FirebaseAuthService();
// //   TextEditingController _passwordController = TextEditingController();
// //   TextEditingController _emailController = TextEditingController();
// //   // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               Center(
// //                 child: Image.asset('assets/auth/login.png'),
// //               ),
// //               const Center(
// //                 child: Text(
// //                   'Hello Again!',
// //                   style: TextStyle(
// //                     color: Colors.black,
// //                     fontFamily: 'DMSans',
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 26,
// //                     letterSpacing: 1,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 15),
// //               const Center(
// //                 child: Text(
// //                   'Welcome back, you\'ve been missed!',
// //                   style: TextStyle(
// //                     fontFamily: 'DMSans',
// //                     color: Colors.black,
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: TextFormField(
// //                   controller: _emailController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Email',
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10.0),
// //                     ),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter an Email';
// //                     } else if (!RegExp(
// //                             r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
// //                         .hasMatch(value)) {
// //                       return 'Please enter a valid Email';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                 child: TextFormField(
// //                   controller: _passwordController,
// //                   obscureText: _isObscure,
// //                   decoration: InputDecoration(
// //                     labelText: 'Password',
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10.0),
// //                     ),
// //                     suffixIcon: IconButton(
// //                       icon: Icon(
// //                         _isObscure ? Icons.visibility_off : Icons.visibility,
// //                       ),
// //                       onPressed: () {
// //                         setState(() {
// //                           _isObscure = !_isObscure;
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter a password';
// //                     } else if (value.length < 6) {
// //                       return 'Password must be at least 6 characters';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 240.0, top: 10.0),
// //                 child: TextButton(
// //                   onPressed: () {},
// //                   child: const Text(
// //                     'Forgot Password?',
// //                     style: TextStyle(
// //                       color: Colors.black,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               Center(
// //                 child: ElevatedButton(
// //                   onPressed: () async {
// //                     if (_formKey.currentState!.validate()) {
// //                       await _signIn();
// //                     }
// //                   },
// //                   child: const Text(
// //                     'Login',
// //                     style: TextStyle(color: Colors.white, fontSize: 20),
// //                   ),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.teal[300],
// //                     padding: const EdgeInsets.symmetric(
// //                       horizontal: 120,
// //                       vertical: 15,
// //                     ),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(15),
// //                       side: BorderSide(color: Colors.teal[300]!),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               RichText(
// //                 text: TextSpan(
// //                   text: "Don't have an Account? ",
// //                   style: TextStyle(fontFamily: 'DMSans', color: Colors.black),
// //                   children: [
// //                     TextSpan(
// //                       text: 'Sign Up',
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black,
// //                         decoration: TextDecoration.underline,
// //                       ),
// //                       recognizer: TapGestureRecognizer()
// //                         ..onTap = () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => Signup(),
// //                             ),
// //                           );
// //                         },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _signIn() async {
// //     String email = _emailController.text;
// //     String password = _passwordController.text;

// //     User? user = await _auth.signInWithEmailAndPassword(email, password);

// //     if (user != null) {
// //       print("Login Successful");
// //       await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('favorites').doc('favoritesData').set({
// //         'data': [], // You can initialize with an empty array or any default data
// //       });
// //       Fluttertoast.showToast(
// //         msg: "Login successful!",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         timeInSecForIosWeb: 1,
// //         backgroundColor: Colors.green,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //       );

      
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => Dashboard(),
// //         ),
// //       );
// //     } else {
// //       print("Login Failed");
// //       Fluttertoast.showToast(
// //         msg: "Login failed. Please try again.",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         timeInSecForIosWeb: 1,
// //         backgroundColor: Colors.red,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //       );
// //     }
// //   }

// // }



// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:receptoria1/pages/backend/firebase_user_auth.dart';
// import 'package:receptoria1/pages/auth/signup.dart';
// import 'package:receptoria1/pages/navbar/dashboard.dart';

// class Login extends StatefulWidget {
//   const Login({Key? key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool _isObscure = true;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Center(
//                 child: Image.asset('assets/auth/login.png'),
//               ),
//               const Center(
//                 child: Text(
//                   'Hello Again!',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'DMSans',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 26,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               const Center(
//                 child: Text(
//                   'Welcome back, you\'ve been missed!',
//                   style: TextStyle(
//                     fontFamily: 'DMSans',
//                     color: Colors.black,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an Email';
//                     } else if (!RegExp(
//                             r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
//                         .hasMatch(value)) {
//                       return 'Please enter a valid Email';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextFormField(
//                   controller: _passwordController,
//                   obscureText: _isObscure,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscure ? Icons.visibility_off : Icons.visibility,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isObscure = !_isObscure;
//                         });
//                       },
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a password';
//                     } else if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 240.0, top: 10.0),
//                 child: TextButton(
//                   onPressed: _resetPassword,
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await _signIn();
//                     }
//                   },
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal[300],
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 120,
//                       vertical: 15,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       side: BorderSide(color: Colors.teal[300]!),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               RichText(
//                 text: TextSpan(
//                   text: "Don't have an Account? ",
//                   style: TextStyle(fontFamily: 'DMSans', color: Colors.black),
//                   children: [
//                     TextSpan(
//                       text: 'Sign Up',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         decoration: TextDecoration.underline,
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Signup(),
//                             ),
//                           );
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _signIn() async {
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     if (user != null) {
//       print("Login Successful");
//       // Your existing code for successful login
//     } else {
//       print("Login Failed");
//       // Your existing code for failed login
//     }
//   }

//   Future<void> _resetPassword() async {
//     String email = _emailController.text;
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//       Fluttertoast.showToast(
//         msg: "Password reset email sent!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to send reset email. Please try again.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receptoria1/pages/auth/forgotpassword.dart';
import 'package:receptoria1/pages/backend/firebase_user_auth.dart';
import 'package:receptoria1/pages/auth/signup.dart';
import 'package:receptoria1/pages/navbar/dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Image.asset('assets/auth/login.png'),
              ),
              const Center(
                child: Text(
                  'Hello Again!',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
             Padding(
                padding: const EdgeInsets.only(left: 240.0, top: 10.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(), // Navigate to ForgotPasswordScreen
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _signIn();
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[300],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 120,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.teal[300]!),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Don't have an Account? ",
                  style: TextStyle(fontFamily: 'DMSans', color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
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
                              builder: (context) => Signup(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("Login Successful");
      // Your existing code for successful login
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('favorites').doc('favoritesData').set({
        'data': [], // You can initialize with an empty array or any default data
      });
      Fluttertoast.showToast(
        msg: "Login successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } else {
      print("Login Failed");
      // Your existing code for failed login
       Fluttertoast.showToast(
        msg: "Login failed. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}


