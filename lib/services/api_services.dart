import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/castmodel.dart';
import 'package:movie_app/models/detailmodel.dart';
import 'package:movie_app/models/nowplaying.dart';
import 'package:movie_app/models/popularseeall.dart';
import 'package:movie_app/models/trendingnowseeall.dart';

class ApiServices {
  final Dio dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org",
      queryParameters: {"api_key": "14fa59313d0e28c6bed3e07f77942ce5"}));

//trending api//
  Future<ApiModel> nowtrending() async {
    try {
      Response response = await dio.get("/3/movie/now_playing");
      if (response.statusCode == 200) {
        final json = jsonEncode(response.data);
        return apiModelFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }

    throw Exception();
  }

//details of movies//
  Future<DetailModel> detailmovie(int movieid) async {
    try {
      Response response = await dio.get("/3/movie/$movieid");
      if (response.statusCode == 200) {
        final json = jsonEncode(response.data);
        return detailModelFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  //trending all provider day//
  Future<TrendinNowSeeAll> trendingseeallday() async {
    Response response = await dio.get("/3/trending/movie/day");
    try {
      if (response.statusCode == 200) {
        final json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }
  //trending all provider day//

  Future<TrendinNowSeeAll> trendingseeallweak() async {
    try {
      Response response = await dio.get("/3/trending/movie/week");
      if (response.statusCode == 200) {
        final json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  //popular see all//
  Future<TrendinNowSeeAll> getpopularseeall() async {
    try {
      Response response = await dio.get("/3/movie/popular");
      if (response.statusCode == 200) {
        final json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  Future<TrendinNowSeeAll> gettoprated() async {
    try {
      Response response = await dio.get("/3/movie/top_rated");
      if (response.statusCode == 200) {
        final json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  Future<TrendinNowSeeAll> upcomingmovies() async {
    try {
      Response response = await dio.get("/3/movie/upcoming");
      if (response.statusCode == 200) {
        final json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  //indian movies//

  //malayalam provider//

  Future<TrendinNowSeeAll> getmalayalammovies() async {
    try {
      Response response = await dio.get("/3/discover/movie",
          queryParameters: {"with_original_language": "ml"});

      if (response.statusCode == 200) {
        String json = jsonEncode(response.data);

        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  Future<TrendinNowSeeAll> gettamilmovies() async {
    try {
      Response response = await dio.get("/3/discover/movie",
          queryParameters: {"with_original_language": "ta"});

      if (response.statusCode == 200) {
        String json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  Future<TrendinNowSeeAll> gethindimovies() async {
    try {
      Response response = await dio.get("/3/discover/movie",
          queryParameters: {"with_original_language": "hi"});

      if (response.statusCode == 200) {
        String json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

  Future<TrendinNowSeeAll> gettelugumovies() async {
    try {
      Response response = await dio.get("/3/discover/movie",
          queryParameters: {"with_original_language": "te"});

      if (response.statusCode == 200) {
        String json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }

//search movies//
  Future<TrendinNowSeeAll> searchmovies(String movies) async {
    try {
      Response response =
          await dio.get("/3/search/movie", queryParameters: {"query": movies});
      log("from searchMovies ${response.statusCode}");
      if (response.statusCode == 200) {
        var json = jsonEncode(response.data);
        return trendinNowSeeAllFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception("Somthing went worng");
  }

//castmodel from json//

  Future<CastModel> getcast(movieid) async {
    try {
      Response response = await dio.get("/3/movie/${movieid}/credits");
      if (response.statusCode == 200) {
        var json = jsonEncode(response.data);
        return castModelFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }
}

final apiserviceProvider = Provider<ApiServices>((ref) {
  return ApiServices();
});
