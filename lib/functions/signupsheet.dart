import 'package:flutter/material.dart';
import 'package:movie_app/screens/signuppage.dart';

class SignupSheet {
  Future<dynamic> signupsheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      context: context,
      builder: (context) => const SignUp(),
    );
  }
}
