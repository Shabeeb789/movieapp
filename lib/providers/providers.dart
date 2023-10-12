import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/castmodel.dart';
import 'package:movie_app/models/detailmodel.dart';
import 'package:movie_app/models/nowplaying.dart';
// import 'package:movie_app/models/popularseeall.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/services/api_services.dart';

final AnimatedSplashProvider = Provider<List<Color>>((ref) {
  return [
    Colors.teal,
    const Color.fromARGB(255, 199, 240, 236),
    Color.fromARGB(255, 0, 255, 128),
    Color.fromARGB(255, 212, 255, 0),
    Colors.teal,
  ];
});

//navigation provider//

final navigationProvider = StateProvider<int>((ref) {
  return 0;
});

//darkmodelightmode provider//
final modeProvider = StateProvider<bool>((ref) {
  return true;
});

//trending provider//
final mainnowplayprovider = FutureProvider<ApiModel>((ref) async {
  return ref.watch(apiserviceProvider).nowtrending();
});
//detailprovider//
final detailProvider =
    FutureProvider.family<DetailModel, int>((ref, movieid) async {
  return ref.watch(apiserviceProvider).detailmovie(movieid);
});

//trendingnowseeall provider//
final trendingnowseeallProviderday =
    FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).trendingseeallday();
});

//trendingnowseeall provider//
final trendingnowseeallProviderweak =
    FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).trendingseeallweak();
});

//popularseeall provider//
final popularseeallProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).getpopularseeall();
});

//toprated provider//
final topratedProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).gettoprated();
});

//upcoming movies//

final upcomingProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).upcomingmovies();
});

//cast provider//

final castProvider =
    FutureProvider.family<CastModel, int>((ref, movieid) async {
  return ref.watch(apiserviceProvider).getcast(movieid);
});

//bottom navigationbar provider//

// final navigationProvider = StateProvider<int>((ref) {
//   return 0;
// });

// loading loader on auth

final loadingProvider = StateProvider<bool>((ref) {
  return false;
});
