

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uthao1/AllScreens/loginScreen.dart';
import 'package:uthao1/AllScreens/mainscreen.dart';
import 'package:uthao1/main.dart';


class RegistrationScreen extends StatelessWidget
{

  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // get firebaseUser => null;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 35.0,),
              Image(
                image: AssetImage("images/mainlogo.png"),
                width: 380.0,
                height: 260.0,
                alignment: Alignment.center,

              ),
              SizedBox(height: 1.0,),
              Text(
                "Signup as a Rider",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,

              ),
              Padding(
                padding:EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),


                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "ContactNo.",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 15.0,),
                    RaisedButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: ()
                      {
                        if(nameTextEditingController.text.length < 3){

                          displayToastMessage("name must be at least 3 characters.", context);
                        }
                        else if (!emailTextEditingController.text.contains("@"))
                          {
                            displayToastMessage("Email address is not valid.", context);
                          }
                        else if (phoneTextEditingController.text.isEmpty)
                          {
                            displayToastMessage("Contact number is needed!", context);
                          }
                        else if (passwordTextEditingController.text.length < 7)
                        {
                          displayToastMessage("Password must be at least 7 characters.", context);
                        }
                        else
                        {
                          registerNewUser(context);
                        }
                        },
                    )
                  ],
                ),
              ),

              FlatButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);

                },
                child: Text(
                  "Already have an Account? Login Here.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  /* void registerNewUser(BuildContext context) async
  {
    final FirebaseUser firebaseUser = (await
    _firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    )).user;
*/
  void registerNewUser(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text);

      /*print(userCredential.user.email);*/ // Returns the user from user credential
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }


    if(firebaseUser !=Null)
      {


        Map userDataMap = {

          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),

        };

        usersRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage("Congratulations, your account has been created.", context);

        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);

      }
    else
      {
        displayToastMessage("New user account has not been created.", context);
      }
  }

  }

displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}


