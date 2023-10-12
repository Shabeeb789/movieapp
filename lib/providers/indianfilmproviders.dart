
//malayalamfilmprovider//

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/services/api_services.dart';

//malayalam film provider//
final malayalamfilmProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).getmalayalammovies() ;
});

//tamilfilmprovider//

final tamilfilmProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).gettamilmovies();
});

//hindifilmprovider//
final hindifilmProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).gethindimovies() ;
});

//telugufilmprovider//

final telugufilmProvider = FutureProvider<TrendinNowSeeAll>((ref) async {
  return ref.watch(apiserviceProvider).gettelugumovies();
});