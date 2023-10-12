import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/screens/carousilappbar.dart';
import 'package:movie_app/screens/indianMovies.dart';
import 'package:movie_app/screens/popularmoviesonhomepage.dart';
import 'package:movie_app/screens/profiledrawer.dart';
import 'package:movie_app/screens/searchui.dart';
import 'package:movie_app/screens/topratedhomes.dart';

import 'package:movie_app/screens/trendingmovieshomepage.dart';
import 'package:movie_app/screens/trendingnowseeall.dart';
import 'package:movie_app/screens/upcominghomescreen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final trendingcarousil = ref.watch(mainnowplayprovider);
    final mode = ref.watch(modeProvider);
    final navigationchange = ref.watch(navigationProvider);
    return navigationchange == 0
        ? Scaffold(
            // appBar: AppBar(),
            drawer: ProfileDrawer(),
            backgroundColor:
                mode ? const Color(0xff222222) : const Color(0xFFFFFFFF),
            //body//

            body: CustomScrollView(
              //sliver appbar//
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  backgroundColor:
                      mode ? const Color(0xff222222) : Colors.white,
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: ResponsiveSize.height(30, context),
                          width: ResponsiveSize.height(30, context),
                          child: Image.asset(
                            "assets/images/icons/flashicon.png",
                            fit: BoxFit.contain,
                          )),
                      Text(
                        "Flash Movies",
                        style: TextStyle(
                            color: mode ? maincolor : Colors.black,
                            fontFamily: "Righteous",
                            fontSize: ResponsiveSize.width(24, context)),
                      ),
                    ],
                  ),
                  expandedHeight: ResponsiveSize.height(430, context),
                  flexibleSpace: FlexibleSpaceBar(
                    background: trendingcarousil.when(
                      data: (data) => CarousilAppBar(data: data),
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
                    ),
                  ),
                  leading: Builder(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all((8.0)),
                        child: CircleAvatar(
                          // radius: 10,
                          backgroundColor: const Color(0x54FFFFFF),
                          child: IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();

                              // print(ref
                              //     .watch(apiservicesProvider)
                              //     .getsearchmovies("cbi 5"));
                            },
                            // tooltip:
                            //     MaterialLocalizations.of(context).openAppDrawerTooltip,
                            icon: Icon(
                              Icons.person,
                              color: !mode
                                  ? const Color(0xff0a141c)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //sliver to boxadapter//

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveSize.width(15, context)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Trending Now",
                              style: TextStyle(
                                  color: !mode
                                      ? const Color(0xff0a141c)
                                      : Colors.white,
                                  fontFamily: "Righteous",
                                  fontSize: ResponsiveSize.width(16, context)),
                            ),
                            InkWell(
                              onTap: () => moviesgrid(
                                  context, trendingnowseeallProviderday, 0),
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: !mode
                                        ? const Color(0xff0a141c)
                                        : Colors.white,
                                    fontFamily: "Righteous",
                                    fontSize:
                                        ResponsiveSize.width(12, context)),
                              ),
                            ),
                          ],
                        ),
                        //trending images on home page//
                        SizedBox(
                          height: ResponsiveSize.height(10, context),
                        ),

                        TrendingMovies(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " Popular Movies",
                              style: TextStyle(
                                  color: !mode
                                      ? const Color(0xff0a141c)
                                      : Colors.white,
                                  fontFamily: "Righteous",
                                  fontSize: ResponsiveSize.width(20, context)),
                            ),
                            InkWell(
                              onTap: () =>
                                  moviesgrid(context, popularseeallProvider, 1),
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: !mode
                                        ? const Color(0xff0a141c)
                                        : Colors.white,
                                    fontFamily: "Righteous",
                                    fontSize:
                                        ResponsiveSize.width(12, context)),
                              ),
                            ),
                          ],
                        ),

                        //popular movies on home page//
                        SizedBox(
                          height: ResponsiveSize.height(10, context),
                        ),

                        PopularMOviesHome(),

                        //toprated movies//

                        SizedBox(
                          height: ResponsiveSize.height(10, context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " Top Rated Movies",
                              style: TextStyle(
                                  color: !mode
                                      ? const Color(0xff0a141c)
                                      : Colors.white,
                                  fontFamily: "Righteous",
                                  fontSize: ResponsiveSize.width(20, context)),
                            ),
                            InkWell(
                              onTap: () =>
                                  moviesgrid(context, topratedProvider, 2),
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: !mode
                                        ? const Color(0xff0a141c)
                                        : Colors.white,
                                    fontFamily: "Righteous",
                                    fontSize:
                                        ResponsiveSize.width(12, context)),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: ResponsiveSize.height(10, context),
                        ),

                        TopRated(),

                        //upcoming movies//

                        SizedBox(
                          height: ResponsiveSize.height(10, context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " Up Coming Movies",
                              style: TextStyle(
                                  color: !mode
                                      ? const Color(0xff0a141c)
                                      : Colors.white,
                                  fontFamily: "Righteous",
                                  fontSize: ResponsiveSize.width(20, context)),
                            ),
                            InkWell(
                              onTap: () =>
                                  moviesgrid(context, upcomingProvider, 2),
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: !mode
                                        ? const Color(0xff0a141c)
                                        : Colors.white,
                                    fontFamily: "Righteous",
                                    fontSize:
                                        ResponsiveSize.width(12, context)),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: ResponsiveSize.height(10, context),
                        ),
                        UPcomingMovies(),

                        //
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //bottom navigation bar//

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
                print("shabeb");
              },
            ))
        : navigationchange == 1
            ? IndianMovies()
            : Searchmovies();
  }
}

void moviesgrid(
    BuildContext context, FutureProvider<TrendinNowSeeAll> dayimages, int val) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeeAll(
          imagesday: dayimages,
          val: val,
        ),
      ));
}
