import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/providers/indianfilmproviders.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/screens/detailpage.dart';
import 'package:movie_app/utilities/api_key.dart';

class IndianMovies extends ConsumerWidget {
  const IndianMovies({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int ind = ref.watch(indiansmoviesprovider);
    int navigationchange = ref.watch(navigationProvider);
    bool mode = ref.watch(modeProvider);

    // List<FutureProvider<MainMovieModels>> listindmovies = [
    //   malayalamprovider,
    //   hindiprovider,
    //   tamilprovider,
    //   teluguprovider,
    // ];
    // var indian = ref.watch(listindmovies[ind]);
    List<FutureProvider<TrendinNowSeeAll>> listindianmovies = [
      malayalamfilmProvider,
      tamilfilmProvider,
      hindifilmProvider,
      telugufilmProvider,
    ];
//indian film provider//

    var indainfilms = ref.watch(listindianmovies[ind]);
    return Scaffold(
      backgroundColor: mode ? const Color(0xff222222) : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mode ? const Color(0xff222222) : Colors.white,
        centerTitle: true,
        title: Text(
          "Indian Movies",
          style: TextStyle(
              color: mode ? maincolor : Colors.black,
              fontFamily: "Righteous",
              fontSize: ResponsiveSize.width(24, context)),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size(double.infinity, ResponsiveSize.height(60, context)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FlutterToggleTab(
              // width in percent
              width: ResponsiveSize.width(90, context),
              borderRadius: 5,
              height: ResponsiveSize.height(30, context),
              selectedIndex: ind,
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
              labels: const ["Malaylam", "Tamil", "Hindi", "Telugu"],
              selectedLabelIndex: (index) {
                ref.read(indiansmoviesprovider.notifier).state = index;
              },
              isScroll: true,
            ),
          ),
        ),
      ),
      body: indainfilms.when(
        data: (data) => buildindianmovies(data, listindianmovies[ind], mode),
        error: (error, stackTrace) => const Text("error"),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mode ? const Color(0xff222222) : Colors.white,
        selectedItemColor: mode ? maincolor : Colors.red,
        unselectedItemColor: mode ? Colors.white : Colors.black,
        items: [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(
              navigationchange == 0 ? Icons.home : Icons.home_outlined,
            ),
          ),
          const BottomNavigationBarItem(
            label: "Indian",
            icon: Icon(
              Icons.movie,
            ),
          ),
          const BottomNavigationBarItem(
            label: "Search",
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        currentIndex: navigationchange,
        onTap: (value) {
          ref.read(navigationProvider.notifier).state = value;
        },
      ),
    );
  }

  GridView buildindianmovies(TrendinNowSeeAll data,
      FutureProvider<TrendinNowSeeAll> indian, bool mode) {
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
          child: data.results![index].posterPath == null
              ? Icon(
                  Icons.block,
                  color: mode ? Colors.white : Colors.black,
                  size: 40,
                )
              : Container(
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

final indiansmoviesprovider = StateProvider<int>((ref) {
  return 0;
});
