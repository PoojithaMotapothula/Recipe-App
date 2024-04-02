// import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:lottie/lottie.dart';
import 'package:open_mail_app/open_mail_app.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              Center(
                child: Lottie.asset('assets/icons/email.json',
                    height: 300, width: 300),
              ),
              const Text(
                'Password Reset Email Sent Successfully',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'A password reset email has been sent to your email address. Please check your inbox and follow the instructions to reset your password.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  // Android: Will open mail app or show native picker.
                  // iOS: Will open mail app if single mail app found.
                  var result = await OpenMailApp.openMailApp(
                    nativePickerTitle: 'Select email app to open',
                  );

                  // If no mail apps found, show error
                  if (!result.didOpen && !result.canOpen) {
                    // showNoMailAppsDialog(context);

                    // iOS: if multiple mail apps found, show dialog to select.
                    // There is no native intent/default app system in iOS so
                    // you have to do it yourself.
                  } else if (!result.didOpen && result.canOpen) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return MailAppPickerDialog(
                          mailApps: result.options,
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  'Open Gmail App',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.teal[300]!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
