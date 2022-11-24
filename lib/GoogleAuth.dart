import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth extends StatefulWidget {

  @override
  State<GoogleAuth> createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {


  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();


  checklogin()async{

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text("AddProdu"),
              TextField(

                keyboardType: TextInputType.text,
              ),
             SizedBox(height: 20,),
             GestureDetector(
               //firebase cooneect project
               //AND FIREBASE ADD SHA CERTIFICET (CMD TO GET CERTIFICET)

               onTap: ()async{
                 GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
                 GoogleSignInAuthentication googleSignInAuthentication =
                 await googleSignInAccount.authentication;
                 AuthCredential credential = GoogleAuthProvider.credential(
                   accessToken: googleSignInAuthentication.accessToken,
                   idToken: googleSignInAuthentication.idToken,
                 );
                 UserCredential authResult = await _auth.signInWithCredential(credential);
                 User _user = authResult.user;




               },
               child: Container(
                 alignment: Alignment.center,
                 //firebase cooneect project
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


                 child: Text("Loginwithgoogle",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
               ),
             ),

              // ElevatedButton(onPressed: ()async{
              //
              // }, child: Text("LoginWithGoogle"))
            ],
          ),
        ),
      ),
    );
  }
}
