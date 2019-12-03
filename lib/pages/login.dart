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

/////////////////START///////
  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    // When the state of the user sign in is true
    if (isLoggedin) {
      //PUSH REPLACEMENT RESTRICTS THE USER FROM USING BACK TO GO TO THE PREV PAGE
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }

  //////////START

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });
    //Check if the user exist in db using query
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    if(firebaseUser!= null){
      final QuerySnapshot result = await Firestore.instance.collection("users").where("id",isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents =result.documents;

      if(documents.length==0){//INSERT THE USER TO OUR COLLECTION(db)
        //  if none is found with the above id(Result of the query)
        Firestore.instance.collection("users").document(firebaseUser.uid).setData(
            {
              "id": firebaseUser.uid,
              "username": firebaseUser.displayName,
              "profilePicture": firebaseUser.photoUrl,
            });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.displayName);
      }else{
        //IF THE USER EXISTS ALREADY
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[1]['username']);
        await preferences.setString("photoUrl", documents[2]['photoUrl']);
      }
      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));

    }else{
      Fluttertoast.showToast(msg: "Login Failed : (");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text("Login", style: TextStyle(color: Colors.red.shade900),),
        elevation: 0.5,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: FlatButton(
                color: Colors.red.shade900,
          onPressed: (){},
                child: Text("Sign in / Sign up with google", style: TextStyle(color: Colors.white),)),
          ),
          
          Visibility(
              visible: loading ?? true,
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
          )
        ],
      ),
    );
  }
}
