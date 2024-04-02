import 'dart:io';
import 'package:receptoria1/pages/backend/home.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late List<TextEditingController> _titleControllers;
  late List<TextEditingController> _ingredientsControllers;
  late List<TextEditingController> _processControllers;
  late List<TextEditingController> _categoryControllers;
  late List<TextEditingController> _servesControllers;
  late List<TextEditingController> _timeControllers;
  late List<ImagePicker> _imagePickers;
  late List<XFile?> _pickedImages;
  late List<String?> _imageUrls; 

  void initState() {
    super.initState();
    _titleControllers = List.generate(5, (index) => TextEditingController());
    _ingredientsControllers =
        List.generate(5, (index) => TextEditingController());
    _processControllers = List.generate(5, (index) => TextEditingController());
    _categoryControllers = List.generate(5, (index) => TextEditingController());
    _servesControllers = List.generate(5, (index) => TextEditingController());
    _timeControllers = List.generate(5, (index) => TextEditingController());
    _imagePickers = List.generate(5, (index) => ImagePicker());
    _pickedImages = List.generate(5, (index) => null);
    _imageUrls = List.generate(5, (index) => null); 
  }

  Future<String?> _uploadImageToStorage(XFile imageFile, int index) async {
    try {
      final String fileName = 'desserts_$index.jpg';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('desserts').child(fileName);

      final UploadTask uploadTask =
          storageReference.putFile(File(imageFile.path));
      await uploadTask.whenComplete(() {});

      final String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<void> _pickImage(int index) async {
    final XFile? pickedImage =
        await _imagePickers[index].pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final String? imageUrl = await _uploadImageToStorage(pickedImage, index);

      if (imageUrl != null) {
        setState(() {
          _pickedImages[index] = pickedImage;
          _imageUrls[index] = imageUrl;
        });
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _pickedImages[index] = null;
      _imageUrls[index] = null;
    });
  }

  Future<void> postDataToFirestore() async {
    
    CollectionReference foodsCollection =
        FirebaseFirestore.instance.collection('foods');

    for (int i = 0; i < 5; i++) {
      String recipeUuid = Uuid().v4();

           CollectionReference vegCollection =
          foodsCollection.doc('desserts').collection('recipes');

      await vegCollection.add({
        'title': _titleControllers[i].text,
        'ingredients': _ingredientsControllers[i].text,
        'category': _categoryControllers[i].text,
        'serves': _servesControllers[i].text,
        'time': _timeControllers[i].text,
        'image': _imageUrls[i] ?? '',
        'step-1': "",
        'step-2': "",
        'step-3': "",
        'step-4':"",
        'step-5':"",
        'step-6':"",
        'Serving Size': "",
        'Calories': "",
        'Protiens': "",
        'Carbohydrate': "",
        'Fats': "",
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Recipe ${index + 1} :',
                    style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 24,
                        fontFamily: 'DMSerifDisplay',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _titleControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter your Recipe name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _ingredientsControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Ingredients',
                      hintText: 'Enter required Ingredients',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _processControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Process',
                      hintText: 'Steps to describe the recipe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _categoryControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _servesControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Serves',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _timeControllers[index],
                    keyboardType:
                        TextInputType.number, 
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ], 
                    decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'Time Required for cooking',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () => _pickedImages[index] == null
                        ? _pickImage(index)
                        : _removeImage(index),
                    child: _pickedImages[index] == null
                        ? Container(
                            width: double.infinity,
                            height: 50,
                            color: Colors.grey,
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Image.file(
                                File(_pickedImages[index]!.path),
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 12,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => _removeImage(index),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      postDataToFirestore();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Display()),
                      );
                    },
                    child: const Text('Post'),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
