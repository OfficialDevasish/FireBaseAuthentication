import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthprc/ViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginwithAuth extends StatefulWidget {


  @override
  State<loginwithAuth> createState() => _loginwithAuthState();
}

class _loginwithAuthState extends State<loginwithAuth> {


  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();


  cheklogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.containsKey("fullname");
    if(prefs.containsKey("fullname"))
      {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>ViewScreen())
        );
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cheklogin();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: Center(
          child: Text("Login with Auth"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: ()async{


              GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
              GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
              AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken,
              );
              UserCredential authResult = await _auth.signInWithCredential(credential);

              //User  to_user

              User _user = authResult.user;

             // print(_user.displayName.toString());




              var name = _user.displayName.toString();
              var email = _user.email.toString();
              var photo = _user.photoURL.toString();
              var googleid = _user.uid.toString();

              SharedPreferences prefs = await SharedPreferences.getInstance();
              //store key
              prefs.setString("fullname", name);
              prefs.setString("Email", email);
              prefs.setString("photo", photo);
              prefs.setString("id", googleid);



              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>ViewScreen())
              );
            },
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(5),
              width:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green,

                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),


              child:  Text("Login With Google",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),


            ),
          ),
        ),
      )
    );
  }
}
