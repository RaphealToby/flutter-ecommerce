import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // This is like a function which determines wether its d first time d app is used
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;


  @override
  void initState() {
    super.initState();
    // CREATE A METHOD TO DETERMINE IF USER IS SIGNED IN
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    // When the state of the user sign in is true
    if(isLoggedin){
      //PUSH REPLACEMENT RESTRICTS THE USER FROM USING BACK TO GO TO THE PREV PAGE
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
