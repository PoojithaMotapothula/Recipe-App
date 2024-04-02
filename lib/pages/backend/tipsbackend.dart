import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CookingTip {
  final String tipNumber;
  final String tipHeading;
  final String tipDescription;

  CookingTip({
    required this.tipNumber,
    required this.tipHeading,
    required this.tipDescription,
  });
}

class TipsPage extends StatelessWidget {
  final List<CookingTip> _tips = [];
  final List<TextEditingController> _tipNumberControllers =
      List.generate(5, (index) => TextEditingController());
  final List<TextEditingController> _tipHeadingControllers =
      List.generate(5, (index) => TextEditingController());
  final List<TextEditingController> _tipDescriptionControllers =
      List.generate(5, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              for (int i = 0; i < 5; i++)
                Column(
                  children: [
                    TextField(
                      controller: _tipNumberControllers[i],
                      decoration: InputDecoration(labelText: 'Tip $i Number'),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _tipHeadingControllers[i],
                      decoration: InputDecoration(labelText: 'Tip $i Heading'),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _tipDescriptionControllers[i],
                      decoration:
                          InputDecoration(labelText: 'Tip $i Description'),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ElevatedButton(
                onPressed: () {
                  _addCookingTips();
                },
                child: Text('Add Tips'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCookingTips() {
    for (int i = 0; i < 5; i++) {
      String tipNumber = _tipNumberControllers[i].text.trim();
      String tipHeading = _tipHeadingControllers[i].text.trim();
      String tipDescription = _tipDescriptionControllers[i].text.trim();

      if (tipNumber.isNotEmpty &&
          tipHeading.isNotEmpty &&
          tipDescription.isNotEmpty) {
        _tips.add(CookingTip(
          tipNumber: tipNumber,
          tipHeading: tipHeading,
          tipDescription: tipDescription,
        ));
      } else {
        return;
      }
    }

    // Now, _tips list contains 5 tips. You can add them to Firestore or perform any other action.
    _addTipsToFirestore();
  }

  void _addTipsToFirestore() {
    for (CookingTip tip in _tips) {
      FirebaseFirestore.instance.collection('cooking_tips').add({
        'tipNumber': tip.tipNumber,
        'tipHeading': tip.tipHeading,
        'tipDescription': tip.tipDescription,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
