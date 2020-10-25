import 'package:flutter/material.dart';
import 'dart:io';

import 'package:home_emergency_app/net/flutterfire.dart';
import 'package:image_picker/image_picker.dart';

class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  // User input to register/login
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _healthNumber = TextEditingController();
  TextEditingController _insuranceNumber = TextEditingController();
  TextEditingController _conditions = TextEditingController();

  // Profile Image
  File _image;
  final picker = ImagePicker();

  // Get img from gallary
  _imgFromCamera() async {
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  // Get img from camera
  _imgFromGallery() async {
    final image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  // Create a screen to choose between selecting from gallery or take a pic
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: <Widget>[
                // Gallery
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Photo Library"),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                // Gallery
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("Camera"),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.red[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add image -------------------------------------------------
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.red[200],
                  child: _image != null
                      ? ClipRRect(
                          // Put image inside profile
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          // Empty image container
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            // First Name --------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _firstName,
                decoration: InputDecoration(
                  hintText: "John",
                  labelText: "First Name",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            // Last Name -------------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _lastName,
                decoration: InputDecoration(
                  hintText: "Doe",
                  labelText: "Last Name",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            // Address ----------------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _address,
                decoration: InputDecoration(
                  hintText: "12345 123 ST",
                  labelText: "Adress",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            // Health Number -----------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _healthNumber,
                decoration: InputDecoration(
                  hintText: "123",
                  labelText: "Health Number",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            // Insurance Number ---------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _insuranceNumber,
                decoration: InputDecoration(
                  hintText: "123",
                  labelText: "Health Insurance Number",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            // Medical Conditions -------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _conditions,
                decoration: InputDecoration(
                  labelText: "Current and/or Previous Medical Conditions",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            // Submit Button --------------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  await addProfile(
                      _firstName.text,
                      _lastName.text,
                      _address.text,
                      _healthNumber.text,
                      _insuranceNumber.text,
                      _conditions.text,
                      _image.path);
                  Navigator.of(context).pop();
                },
                child: Text("Add Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
