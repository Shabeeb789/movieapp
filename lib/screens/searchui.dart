import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/models/trendingnowseeall.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/providers/searchproviders.dart';
import 'package:movie_app/screens/detailpage.dart';
import 'package:movie_app/utilities/api_key.dart';

class Searchmovies extends ConsumerWidget {
  const Searchmovies({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var search = ref.watch(moviesearchProvider);
    int navigationchange = ref.watch(navigationProvider);

    // TextEditingController _texteditingcontroller = TextEditingController();
    bool mode = ref.watch(modeProvider);

    return Scaffold(
      backgroundColor: mode ? const Color(0xff0a141c) : Colors.white,
      appBar: AppBar(
        //
        //navigator.pop venda//
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: !mode ? const Color(0xff0a141c) : Colors.white,
        //     )),
        backgroundColor: mode ? const Color(0xff0a141c) : Colors.white,
        centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
              color: mode ? maincolor : Colors.black,
              fontFamily: "Righteous",
              fontSize: ResponsiveSize.width(24, context)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(15, context),
                  vertical: ResponsiveSize.height(10, context)),
              child: SizedBox(
                height: ResponsiveSize.height(60, context),
                width: double.infinity,
                child: TextField(
                  // controller: _texteditingcontroller,
                  onChanged: (value) {
                    ref.read(movienameProvider.notifier).state = value;
                    print(value);
                    // _texteditingcontroller.text = value;

                    //automatic refresginaan namml ref.invalidsate use cheyyun//
                    ref.invalidate(moviesearchProvider);
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: mode ? Colors.white : Colors.black,
                      fontSize: ResponsiveSize.width(12, context)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        mode ? const Color(0xff272111) : Color(0xFF878484),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: mode ? Colors.white : Colors.black,
                    labelText: "Search Movies",
                    labelStyle: TextStyle(
                        color: mode ? Colors.white : Colors.black,
                        fontFamily: "Karla",
                        fontSize: ResponsiveSize.width(12, context)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: search.when(
                data: (data) => searchlist(data, mode),
                error: (error, stackTrace) => const Text("error"),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            // SizedBox(
            //   height: 60,
            // ),
          ],
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

  ListView searchlist(
    TrendinNowSeeAll data,
    bool mode,
  ) {
    // print(data);
    return ListView.separated(
      // shrinkWrap: true,
      // physics: const ScrollPhysics(),
      itemCount: data.results!.length,
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
            padding: EdgeInsets.all(5),
            height: ResponsiveSize.height(120, context),
            width: double.infinity,
            // decoration: BoxDecoration(color: Colors.transparent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ResponsiveSize.height(120, context),
                  width: ResponsiveSize.width(80, context),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: data.results![index].posterPath == null
                        ? Icon(
                            Icons.block,
                            color: mode ? Colors.white : Colors.black,
                            size: 40,
                          )
                        : Image.network(
                            "${ApiKey.imagekey}/w500/${data.results![index].posterPath!}",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: ResponsiveSize.width(10, context)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: ResponsiveSize.width(250, context),
                        child: Text(
                          data.results![index].title!,
                          style: TextStyle(
                              color: maincolor,
                              fontFamily: "Righteous",
                              fontSize: ResponsiveSize.width(16, context)),
                        )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 16,
                        ),
                        Text(
                          data.results![index].voteAverage!.toStringAsFixed(1),
                          style: TextStyle(
                              color: mode ? maincolor : Colors.black,
                              fontFamily: "Righteous",
                              fontSize: ResponsiveSize.width(12, context)),
                        ),
                      ],
                    ),
                    // ignore: unrelated_type_equality_checks
                    data.results![index].releaseDate != null
                        ? Text(
                            DateFormat("yyyy")
                                .format(data.results![index].releaseDate!),
                            style: TextStyle(
                                color: mode ? maincolor : Colors.black,
                                fontFamily: "Righteous",
                                fontSize: ResponsiveSize.width(12, context)),
                          )
                        : const Text(""),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}
