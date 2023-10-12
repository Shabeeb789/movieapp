import 'package:flutter/material.dart';
import 'package:movie_app/constants/responsive.dart';

class SizedBoxsize {
  static SizedBox sizedboxh20(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(20, context),
    );
  }

  static SizedBox sizedboxh40(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(40, context),
    );
  }

  static SizedBox sizedboxh60(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(60, context),
    );
  }

  static SizedBox sizedboxw20(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.width(20, context),
    );
  }

  static SizedBox sizedboxw40(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.width(40, context),
    );
  }

  static SizedBox sizedboxw60(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.width(60, context),
    );
  }
}
