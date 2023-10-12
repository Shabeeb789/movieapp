import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/extension/navigation.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/screens/authchecker.dart';
import 'package:movie_app/screens/loginscreen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 7), () {
      context.goto(AUthChecker());
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final colorchange = ref.watch(AnimatedSplashProvider);
    return Scaffold(
      backgroundColor: maincolor,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: ResponsiveSize.height(120, context)),
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/splash screen/splashscreen1.gif"),
                fit: BoxFit.cover),
          ),
          child: SizedBox(
            height: ResponsiveSize.height(70, context),
            child: AnimatedTextKit(
              pause: const Duration(seconds: 0),
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                ColorizeAnimatedText(
                  'Flash Movies',
                  textStyle: TextStyle(
                    fontFamily: "Comforter",
                    fontSize: ResponsiveSize.width(40, context),
                    fontWeight: FontWeight.w700,
                    // fontStyle: FontStyle.italic,
                  ),
                  colors: colorchange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
