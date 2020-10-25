import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:home_emergency_app/ui/add_user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Profile Image
  File _image;
  final picker = ImagePicker();

  // PDF

  // Get img from gallary
  _imgFromCamera() async {
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  void _emergency() {
    // _imgFromCamera();

    // FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .collection("Profiles")
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((document) {
    //     print(document.data()['Image']);
    //   });
    // });
    String requiredName = "Richmond";

    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Profiles")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((document) async {
        //print(document.data()["FirstName"]);
        if (document.data()["FirstName"] == requiredName) {
          print(document.data()["FirstName"]);
//           var htmlContent = """
// <!DOCTYPE html>
// <html>
// <head>
//   <title>Profile</title>
// </head>
//   <body>
//    <p>First Name: ${document.data()['FirstName'].toString()}</p>
//    <p>Last Name: ${document.data()['LastName'].toString()}</p>
//    <p>Address: ${document.data()['AddressName'].toString()}</p>
//    <p>Health Number: ${document.data()['HealthNumber'].toString()}</p>
//    <p>Health Insurance Number: ${document.data()['InsuranceNumber'].toString()}</p>
//    <p>Medical Conditions: ${document.data()['Conditions'].toString()}</p>
//   </body>
// </html>
// """;
          // final pdf = pw.Document();

          // pdf.addPage(pw.Page(
          //     pageFormat: PdfPageFormat.a4,
          //     build: (pw.Context context) {
          //       return pw.Center(
          //         child: pw.Text(
          //             "First Name: ${document.data()['FirstName'].toString()}"),
          //       );
          //     }));
          // final file = File("example.pdf");
          // //await file.writeAsBytes(pdf.save());

          // final Email email = Email(
          //   body: 'Email body',
          //   subject: 'Email subject',
          //   recipients: ['rtran@ualberta.ca'],
          //   cc: ['cc@example.com'],
          //   bcc: ['bcc@example.com'],
          //   attachmentPaths: [file.path],
          //   isHTML: false,
          // );

          // await FlutterEmailSender.send(email);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.red[50],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 75.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title --------------------------------------------
              Text(
                "Profiles",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              // Profiles ------------------------------------------------
              Flexible(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection("Profiles")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView(
                      children: snapshot.data.docs.map((document) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                "${document.data()['FirstName'].toString()}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              // Emergency Button ----------------------------------------
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.red,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    _emergency();
                  },
                  child: Text(
                    "Emergency",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProfile(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[800],
        ),
        backgroundColor: Colors.red[200],
      ),
    );
  }
}
