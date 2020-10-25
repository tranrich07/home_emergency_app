import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_emergency_app/ui/add_user.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
