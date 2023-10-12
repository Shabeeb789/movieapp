import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/services/firebaseauth.dart';
import 'package:movie_app/services/firebaseuserservices.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final getuser = ref.watch(userServiceprovider);
    //main container in teal color//

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveSize.height(60, context),
        horizontal: ResponsiveSize.width(10, context),
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: maincolor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),

      //detail container//
      child: Container(
        decoration: const BoxDecoration(
            // color: Colors.black,
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
              Color(0xff1e1601),
              Color(0xff020100),
            ])),
        child: Column(
          children: [
            //create account text//
            SizedBox(height: ResponsiveSize.height(30, context)),
            Text(
              "Create your Account",
              style: TextStyle(
                  color: maincolor,
                  fontFamily: "Righteous",
                  fontSize: ResponsiveSize.width(20, context)),
            ),

            //email textfield//

            SizedBox(
              height: ResponsiveSize.height(30, context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(15, context),
                vertical: ResponsiveSize.height(10, context),
              ),
              child: SizedBox(
                height: ResponsiveSize.height(60, context),
                width: double.infinity,
                //email textfield//
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveSize.width(12, context)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff272111),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.white,
                    labelText: "Enter your Email",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        // fontFamily: "Karla",
                        fontSize: ResponsiveSize.width(12, context)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
            ),
            //PASSWORD TEXTFIELD//
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(15, context),
                  vertical: ResponsiveSize.height(10, context)),
              child: SizedBox(
                height: ResponsiveSize.height(60, context),
                width: double.infinity,
                //password textfield//
                child: TextField(
                  obscureText: true,
                  controller: passwordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveSize.width(12, context),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff272111),
                    prefixIcon: Icon(Icons.key),
                    prefixIconColor: Colors.white,
                    suffixIcon: const Icon(Icons.visibility_off),
                    suffixIconColor: Colors.white,
                    labelText: "password",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        // fontFamily: "Karla",
                        fontSize: ResponsiveSize.width(12, context)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
            ),

            //CONFIRM PASSWORD TEXTFIELD//
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(15, context),
                  vertical: ResponsiveSize.height(10, context)),
              child: SizedBox(
                height: ResponsiveSize.height(60, context),
                width: double.infinity,
                //confirm password//
                child: TextField(
                  obscureText: true,
                  controller: confirmpasswordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveSize.width(12, context)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff272111),
                    prefixIcon: Icon(Icons.key),
                    prefixIconColor: Colors.white,
                    suffixIcon: const Icon(Icons.visibility_off),
                    suffixIconColor: Colors.white,
                    labelText: "confirm password",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "Karla",
                        fontSize: ResponsiveSize.width(12, context)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () async {
                  {
                    try {
                      if (emailcontroller.text != "" &&
                          passwordcontroller.text != "" &&
                          confirmpasswordcontroller.text != "") {
                        if (passwordcontroller.text ==
                            confirmpasswordcontroller.text) {}

                        UserCredential userCredential = await ref
                            .read(authProvider)
                            .signup(
                                emailcontroller.text, passwordcontroller.text);
                        ref.read(userServiceprovider).addUser(
                            userCredential.user!.uid,
                            emailcontroller.text.characters.toString(),
                            emailcontroller.text);
                      }
                    } on FirebaseAuthException catch (e) {
                      log(e.toString());
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveSize.width(16, context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
