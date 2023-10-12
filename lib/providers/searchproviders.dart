import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/services/api_services.dart';

final moviesearchProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref
      .watch(apiserviceProvider)
      .searchmovies(ref.watch(movienameProvider));
});

final movienameProvider = StateProvider<String>((ref) {
  return "";
});
