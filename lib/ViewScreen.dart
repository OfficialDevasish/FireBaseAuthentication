import 'package:firebaseauthprc/loginwithAuth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewScreen extends StatefulWidget {


  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  //googlesign declair

  GoogleSignIn _googleSignIn = GoogleSignIn();
  var name="",email="",photo="",id="";

  getdata()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("fullname").toString();
      email = prefs.getString("email").toString();
      photo = prefs.getString("photo").toString();
      id = prefs.getString("id").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("View"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text(name),
              Text(id),
              Text(email),
              Image.network(photo),

              ElevatedButton(onPressed: ()async{

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                _googleSignIn.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>loginwithAuth())
                );

              },

                  child:Text("LogOut"))
            ],
          ),
        ),
      ),
    );
  }
}
