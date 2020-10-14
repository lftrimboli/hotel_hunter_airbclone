import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/appConstants.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';
import 'package:image_picker/image_picker.dart';

import 'guestHomePage.dart';

class SignUpPage extends StatefulWidget {

  static final String routeName = '/signUpPageRoute';

  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  File _imageFile;

  void _chooseImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _imageFile = imageFile;
      setState(() {});
    }
  }

  void _signUp() {
    if (!_formKey.currentState.validate() || this._imageFile == null) { return; }
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: AppConstants.currentUser.email,
      password: AppConstants.currentUser.password,
    ).then((firebaseUser) {
      String userID = firebaseUser.uid;
      AppConstants.currentUser.id = userID;
      AppConstants.currentUser.firstName = _firstNameController.text;
      AppConstants.currentUser.lastName = _lastNameController.text;
      AppConstants.currentUser.city = _cityController.text;
      AppConstants.currentUser.country = _countryController.text;
      AppConstants.currentUser.bio = _bioController.text;
      AppConstants.currentUser.addUserToFirestore().whenComplete(() {
        AppConstants.currentUser.addImageToFirestore(_imageFile).whenComplete(() {
          FirebaseAuth.instance.signInWithEmailAndPassword(
            email: AppConstants.currentUser.email,
            password: AppConstants.currentUser.password,
          ).whenComplete(() {
            Navigator.pushNamed(context, GuestHomePage.routeName);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please enter the following information:',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'First name'
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _firstNameController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a first name";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Last name'
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _lastNameController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a last name";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'City'
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _cityController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a valid city";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Country'
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _countryController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a valid country";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Bio'
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          maxLines: 3,
                          controller: _bioController,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: MaterialButton(
                    onPressed: _chooseImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.8,
                      child: (_imageFile == null) ? Icon(Icons.add) : CircleAvatar(
                        backgroundImage: FileImage(_imageFile),
                        radius: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: MaterialButton(
                    onPressed: () {
                      _signUp();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height / 12,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
