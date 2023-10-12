import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/models/nowplaying.dart';
import 'package:movie_app/screens/newmoviescroller.dart';
import 'package:movie_app/services/api_services.dart';

class CarousilAppBar extends StatelessWidget {
  final ApiModel data;
  const CarousilAppBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: data.results!.length,
      itemBuilder: (context, index, realIndex) {
        return NewMoviesScroller(
          index: index,
        );
      },
      options: CarouselOptions(
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          height: ResponsiveSize.height(450, context),
          autoPlay: true,
          reverse: true,
          enlargeCenterPage: true),
    );
  }
}
