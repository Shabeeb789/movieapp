import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/screens/detailpage.dart';
import 'package:movie_app/utilities/api_key.dart';

// import 'package:movieapp/models/newmoviesl_model.dart';
// import 'package:movieapp/provider/top_rated/toprated.dart';
// import 'package:movieapp/provider/popular_movies/popularmovies.dart';
// import 'package:movieapp/provider/trendingmovies/trendingprovider.dart';

class SeeAll extends ConsumerWidget {
  const SeeAll({
    super.key,
    required this.imagesday,
    required this.val,
  });
  final int val;
  final FutureProvider<TrendinNowSeeAll> imagesday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int daw = ref.watch(dayandweek);
    bool mode = ref.watch(modeProvider);
    var dayimages = ref.watch(imagesday);
    var weekimages = ref.watch(trendingnowseeallProviderweak);

    // double sh = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: mode ? const Color(0xff222222) : Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            val == 0
                ? "Trending Movies"
                : val == 1
                    ? "Populur Movies"
                    : val == 2
                        ? "Top rated movies"
                        : "Upcoming Movies",
            style: TextStyle(
                color: mode ? maincolor : Colors.black,
                fontFamily: "Righteous",
                fontSize: ResponsiveSize.width(24, context)),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: mode ? Colors.white : Colors.black,
              )),
          backgroundColor: mode ? const Color(0xff0a141c) : Colors.white,
          bottom: val == 0
              ? PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 55),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FlutterToggleTab(
                      // width in percent
                      width: 40,
                      borderRadius: 30,
                      height: 30,
                      selectedIndex: daw,
                      selectedBackgroundColors: const [
                        Color(0xFF141313),
                        Color(0xDD171616)
                      ],
                      selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      unSelectedTextStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      labels: const ["day", "week"],
                      selectedLabelIndex: (index) {
                        ref.read(dayandweek.notifier).state = index;
                      },
                      isScroll: true,
                    ),
                  ),
                )
              : null,
        ),
        body: val == 0 && daw == 1
            ? weekimages.when(
                data: (data) => gridlist(
                  ref,
                  data,
                  imagesday,
                  context,
                ),
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
              )
            : dayimages.when(
                data: (data) => gridlist(
                  ref,
                  data,
                  imagesday,
                  context,
                ),
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

  GridView gridlist(
    WidgetRef ref,
    TrendinNowSeeAll data,
    FutureProvider<TrendinNowSeeAll> pro,
    BuildContext context,
  ) {
    // double sh = MediaQuery.of(context).size.height;

    return GridView.builder(
      itemCount: data.results!.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 4,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(movieid: data.results![index].id!),
                ));
          },
          child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey,
              child: Container(
                // height: sh * (180 / Responsive.height),
                // width: sw * (130 / Responsive.width),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          "${ApiKey.imagekey}/w500/${data.results![index].posterPath!}"),
                      fit: BoxFit.cover),
                ),
              )),
        );
      },
    );
  }
}

final dayandweek = StateProvider<int>((ref) {
  return 0;
});
