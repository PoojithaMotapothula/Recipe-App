import 'package:flutter/material.dart';
import 'package:receptoria1/pages/auth/welcome.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
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
                    Image.asset(
                      'assets/display/image3.png',
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '        We Have \n   9000+ Review\n      On Our App ',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'DMSerif',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'We Have 6000+ User User Reviews, \n You Can Check In The Application',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'DMSans'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
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
                                        builder: (context) => const Welcome()),
                                  );
                                },
                                child: const Text(
                                  'Let\'s Go',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal[300],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 120,
                                      vertical: 15), // Adjust size
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15), // Adjust border radius
                                    side: BorderSide(
                                        color: Colors.teal[300]!), // Add border
                                  ),
                                ),
                              ),
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
