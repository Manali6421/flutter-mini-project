import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puffzone/controller/user_controller.dart';
import 'package:puffzone/model/user.dart';
import 'package:puffzone/model/user_data.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserController _userController = UserController();
  var _nameKey = GlobalKey<FormState>();
  var _genderKey = GlobalKey<FormState>();
  var _professionKey = GlobalKey<FormState>();
  var _mobileKey = GlobalKey<FormState>();
  var _emailKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  _nameForm(),
                  SizedBox(
                    height: 20,
                  ),
                  _professionForm(),
                  SizedBox(
                    height: 20,
                  ),
                  _emailForm(),
                  SizedBox(
                    height: 20,
                  ),
                  _genderForm(),
                  SizedBox(
                    height: 20,
                  ),
                  _mobileForm(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: RaisedButton(
                        child: Text('Save',
                            style:
                                TextStyle(fontSize: 22, color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.grey[700],
                        onPressed: () {
                          if (_nameKey.currentState.validate() &&
                              _emailKey.currentState.validate() &&
                              _mobileKey.currentState.validate() &&
                              _genderKey.currentState.validate() &&
                              _professionKey.currentState.validate()) {
                            // addUser();
                            User userobj = User(
                                gender: _genderController.text,
                                email: _emailController.text,
                                mobile: _mobileController.text,
                                jobTitle: _professionController.text,
                                name: _nameController.text);

                            _userController.addUser(userobj);
                            showSnackBar();
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidNumber(String value) {
    return RegExp(r'[0-9]').hasMatch(value.toString());
  }

  bool isValidName(String name) {
    return RegExp(r'[a-zA-Z]').hasMatch(name);
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? AssetImage('assets/logo.jpeg')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Color.fromRGBO(30, 3, 84, 1.0),
                size: 28.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  bottomSheet() {
    return Container(
        height: 100,
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            Text(
              'Choose Profile Photo',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: Text("Camera"),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: Text("Gallery"),
                )
              ],
            )
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  showSnackBar() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('One more user added.'),
      duration: Duration(seconds: 3),
    ));
  }

  Widget _mobileForm() {
    return Form(
      key: _mobileKey,
      child: TextFormField(
        controller: _mobileController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        obscureText: false,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            suffixIcon: Icon(
              Icons.timelapse_rounded,
              color: Colors.indigo,
            ),
            hintText: "Mobile Number"),
        maxLength: 10,
        validator: (Value) {
          if (Value == null || Value.isEmpty) {
            return 'number is required';
          } else if (Value.length < 10) {
            return 'maximum length should be 10';
          } else if (!isValidNumber(Value)) {
            return "Invalid number";
          }

          return null;
        },
      ),
    );
  }

  Widget _genderForm() {
    return Form(
      key: _genderKey,
      child: TextFormField(
        controller: _genderController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            hintText: "Gender"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'gender is required';
          } else if (!isValidName(value)) {
            return "Invalid gender";
          }
          return null;
        },
      ),
    );
  }

  Widget _emailForm() {
    return Form(
      key: _emailKey,
      child: TextFormField(
        controller: _emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            hintText: "Email"),
        validator: (text) {
          if (text.isEmpty) {
            return "email is required";
          } else if (!isValidEmail(text)) {
            return "Invalid email";
          }
          return null;
        },
      ),
    );
  }

  Widget _professionForm() {
    return Form(
      key: _professionKey,
      child: TextFormField(
        controller: _professionController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            hintText: "Profession"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'profession is required';
          } else if (!isValidName(value)) {
            return "Invalid Name";
          }
          return null;
        },
      ),
    );
  }

  Widget _nameForm() {
    return Form(
      key: _nameKey,
      child: TextFormField(
        controller: _nameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            hintText: "Name"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'name is required';
          } else if (isValidName(value)) {
            return null;
          }
          return "Invalid name";
        },
      ),
    );
  }
}
