import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/homepage.dart';
import 'package:movie_app/screens/loginscreen.dart';
import 'package:movie_app/services/firebaseauth.dart';

class AUthChecker extends ConsumerWidget {
  const AUthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authchecker = ref.watch(authstateProvider);
    return authchecker.when(
      data: (data) {
        log("$data");
        if (data == null) {
          return LoginScreen();
        } else {
          return HomeScreen();
        }
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
