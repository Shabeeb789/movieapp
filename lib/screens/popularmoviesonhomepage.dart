import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/screens/detailpage.dart';
import 'package:movie_app/utilities/api_key.dart';

class PopularMOviesHome extends ConsumerWidget {
  const PopularMOviesHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularmovies = ref.watch(popularseeallProvider);

    return popularmovies.when(
      data: (data) => listvewpop(ref, data, context),
      error: (error, stackTrace) {
        return const Center(
          child: Text("no data"),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  SizedBox listvewpop(
      WidgetRef ref, TrendinNowSeeAll data, BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(190, context),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => DetailPage(movieid: data.results![index].id!),
            child: Container(
              height: ResponsiveSize.height(180, context),
              width: ResponsiveSize.width(130, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        "${ApiKey.imagekey}/w500/${data.results![index].posterPath!}"),
                    fit: BoxFit.cover),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: ResponsiveSize.width(10, context),
          );
        },
      ),
    );
  }
}
