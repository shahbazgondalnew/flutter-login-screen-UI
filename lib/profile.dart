import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_user/main.dart';
import 'package:login_user/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profileState();
}

class _profileState extends State<profilePage> {
  var dpLink =
      "https://firebasestorage.googleapis.com/v0/b/flutter2022-17ba0.appspot.com/o/dp.png?alt=media&token=60f6bc0b-1e27-4a79-b0c6-a54ff81beb0c";

  String name = "Loading...";
  String email = "Loading...";
  String city = "Loading...";
  String loginuid = "Loading...";
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: CachedNetworkImage(
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  imageUrl: dpLink,
                  // ignore: prefer_const_constructors
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Uid: $loginuid"),
              const SizedBox(
                height: 10,
              ),
              Text("Name: $name"),
              const SizedBox(
                height: 10,
              ),
              Text("Email: $email"),
              const SizedBox(
                height: 10,
              ),
              Text("City: $city"),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.black)))),
                    child: const Text(
                      "Log Out",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                  )),
                ],
              ),
            ]),
      ),
    );
  }

  Future<void> getData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String currentlogin = auth.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          loginuid = currentlogin;
          city = doc["city"].toString();
          email = doc["email"].toString();

          name = doc["name"].toString();
        });
      });
    });
  }
}
