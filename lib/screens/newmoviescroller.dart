import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/models/nowplaying.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/screens/detailpage.dart';
import 'package:movie_app/utilities/api_key.dart';

class NewMoviesScroller extends ConsumerWidget {
  const NewMoviesScroller({
    required this.index,
    super.key,
  });
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool mode = ref.watch(modeProvider);

    var nowplayingmain = ref.watch(mainnowplayprovider);
    return SingleChildScrollView(
        child: nowplayingmain.when(
      data: (data) => nowplayinglist(context, ref, data, mode),
      error: (error, stackTrace) {
        return const Center(
          child: Text("error"),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }

  Column nowplayinglist(
      BuildContext context, WidgetRef ref, ApiModel data, bool mode) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: ResponsiveSize.height(160, context)),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(movieid: data.results![index].id!),
                ));
          },
          child: Container(
            width: ResponsiveSize.width(275, context),
            height: ResponsiveSize.height(260, context),
            padding: EdgeInsets.all(ResponsiveSize.width(20, context)),
            decoration: BoxDecoration(
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(
                      "${ApiKey.imagekey}/w500/${data.results![index].posterPath!}"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: ResponsiveSize.width(8, context)),
              padding: EdgeInsets.all(ResponsiveSize.width(8, context)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  Text(
                    data.results![index].voteAverage.toString(),
                    style: TextStyle(
                        color: mode ? maincolor : Colors.black,
                        fontFamily: "Righteous",
                        fontSize: ResponsiveSize.width(12, context)),
                  ),
                ],
              ),
            ),
            SizedBox(height: ResponsiveSize.height(8, context)),
            Container(
              margin: EdgeInsets.only(right: ResponsiveSize.width(8, context)),
              padding: EdgeInsets.all(ResponsiveSize.width(8, context)),
              child: SizedBox(
                width: 150,
                child: Text(
                  data.results![index].title!,
                  style: TextStyle(
                      color: mode ? maincolor : Colors.black,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(12, context)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
