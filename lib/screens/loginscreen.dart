import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/constants/sizedboxsize.dart';

import 'package:movie_app/functions/signupsheet.dart';
import 'package:movie_app/providers/providers.dart';

import 'package:movie_app/services/firebaseauth.dart';
import 'package:movie_app/services/firebaseuserservices.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginprovider = ref.watch(authstateProvider);
    return Scaffold(
        backgroundColor: Colors.black,
        body: ref.watch(loadingProvider)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: ResponsiveSize.height(50, context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: ResponsiveSize.height(30, context),
                            width: ResponsiveSize.width(30, context),
                            child: Image.asset(
                              "assets/images/icons/flashicon.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            "Flash Movies",
                            style: TextStyle(
                                color: Colors.teal,
                                fontFamily: "Righteous",
                                fontSize: ResponsiveSize.height(48, context)),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveSize.height(2, context)),
                      Text(
                        "Unlimited Movie Reviews",
                        style: TextStyle(
                          color: maincolor,
                          fontFamily: "Righteous",
                          fontSize: ResponsiveSize.height(18, context),
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(25, context)),
                      Text(
                        "Sign in Your Account",
                        style: TextStyle(
                            color: maincolor,
                            fontFamily: "Righteous",
                            fontSize: ResponsiveSize.height(16, context)),
                      ),

                      //email and password textfield//
                      //email//

                      SizedBox(
                        height: ResponsiveSize.height(35, context),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveSize.width(15, context),
                            vertical: ResponsiveSize.height(10, context)),
                        //email textfield//
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: const Color(0xffffffff),
                              fontSize: ResponsiveSize.width(12, context)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            prefixIconColor: const Color(0xffffffff),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: const Color(0xffffffff),
                                fontFamily: "Righteous",
                                fontSize: ResponsiveSize.width(12, context)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveSize.width(15, context),
                            vertical: ResponsiveSize.height(10, context)),
                        child: TextField(
                          obscureText: true,
                          controller: password,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: const Color(0xffffffff),
                              fontSize: ResponsiveSize.width(12, context)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            prefixIconColor: const Color(0xffffffff),
                            suffixIcon: const Icon(Icons.visibility_off),
                            suffixIconColor: const Color(0xffffffff),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: const Color(0xffffffff),
                                fontFamily: "Righteous",
                                fontSize: ResponsiveSize.width(12, context)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ),

                      //continue button//
                      SizedBox(
                        height: ResponsiveSize.height(10, context),
                      ),

                      //
                      InkWell(
                        onTap: () async {
                          if (email.text != "" && password.text != "") {
                            try {
                              await ref
                                  .read(authProvider)
                                  .signin(email.text, password.text);
                            } on FirebaseAuthException catch (e) {
                              log(e.message.toString());
                            }
                          }

                          // print("aswal");
                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     transitionDuration: const Duration(milliseconds: 3000),
                          //     transitionsBuilder:
                          //         (context, animation, secondaryAnimation, child) =>
                          //             ScaleTransition(
                          //       scale: animation,
                          //       child: child,
                          //     ),
                          //     pageBuilder: (context, animation, secondaryAnimation) =>
                          //         const HomeScreen(),
                          //   ),
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: ResponsiveSize.height(40, context),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const RadialGradient(
                                radius: 6,
                                focalRadius: 5,
                                colors: [Colors.white, Colors.teal],
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: const Color(0xff000000),
                                  fontFamily: "Righteous",
                                  fontSize: ResponsiveSize.width(16, context)),
                            ),
                          ),
                        ),
                      ),

                      //or text//
                      SizedBoxsize.sizedboxh20(context),
                      Text(
                        "OR",
                        style: TextStyle(
                          color: whitecolor,
                          fontSize: ResponsiveSize.width(16, context),
                        ),
                      ),
                      //login with google//
                      SizedBoxsize.sizedboxh20(context),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveSize.width(16, context)),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            minimumSize: Size(
                              double.infinity,
                              ResponsiveSize.height(40, context),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () async {
                            ref.read(loadingProvider.notifier).state = true;
                            UserCredential userCredential =
                                await ref.read(authProvider).signInWithGoogle();
                            if (userCredential.user != null) {
                              log("${userCredential.user!.email}  ${userCredential.user!.displayName}");
                              UserService().addUser(
                                  userCredential.user!.uid,
                                  userCredential.user!.displayName.toString(),
                                  userCredential.user!.email.toString());
                            }
                            ref.read(loadingProvider.notifier).state = false;
                          },
                          icon: SizedBox(
                            height: ResponsiveSize.height(20, context),
                            width: ResponsiveSize.width(20, context),
                            child:
                                Image.asset("assets/images/google/google.png"),
                          ),
                          label: const Text(
                            "Login with phone",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),

                      //login with phone//

                      SizedBox(
                        height: ResponsiveSize.height(10, context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: ResponsiveSize.height(40, context),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.phone_android,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Login with phone",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                side: const BorderSide(
                                  width: 1,
                                ),
                                backgroundColor: maincolor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: InkWell(
            onTap: () {
              SignupSheet().signupsheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  height: ResponsiveSize.height(60, context),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 4,
                        width: ResponsiveSize.width(80, context),
                        color: Colors.grey,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Righteous",
                          fontSize: ResponsiveSize.width(16, context),
                        ),
                      ),
                    ],
                  )),
            )));
  }
}
