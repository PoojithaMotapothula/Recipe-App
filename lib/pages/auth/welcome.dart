import 'package:flutter/material.dart';
import 'package:receptoria1/pages/auth/login.dart';
import 'package:receptoria1/pages/auth/signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Flavor Bytes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 43,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      'assets/auth/welcome.png',
                      alignment: Alignment.center,
                      scale: 1.8,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'DMSans',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '         Come join us now\n create an account or login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'DMSans'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Colors.teal[300], fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 15), // Adjust size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Adjust border radius
                                side: BorderSide(
                                    color: Colors.black38!), // Add border
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[300],
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 15), // Adjust size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Adjust border radius
                                side: BorderSide(
                                    color: Colors.teal[300]!), // Add border
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                  'By signing up, you are agreeing to our User Agreement\n                             and Privacy Policy.'),
                            )
                          ],
                        )
                      ],
                    )
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
