import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/responsive.dart';
import 'package:movie_app/constants/sizedboxsize.dart';
import 'package:movie_app/models/detailmodel.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utilities/api_key.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({required this.movieid, super.key});
  final int movieid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(modeProvider);
    final item = ref.watch(detailProvider(movieid));
    final cast = ref.watch(castProvider(movieid));

    return Scaffold(
      backgroundColor: mode ? const Color(0xff222222) : Colors.white,
      appBar: AppBar(
        backgroundColor: mode ? const Color(0xff222222) : Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: mode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(
              color: !mode ? const Color(0xff0a141c) : maincolor,
              fontFamily: "Righteous",
              fontSize: ResponsiveSize.width(20, context)),
        ),
      ),

      //body//

      body: SingleChildScrollView(
        child: Column(
          children: [
            item.when(
              data: (data) => detailview(data, mode, ref, context),
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
            cast.when(
              data: (data) {
                return SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: data.cast!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          data.cast![index].profilePath == null
                              ? Icon(Icons.person)
                              : Container(
                                  height: ResponsiveSize.height(90, context),
                                  width: ResponsiveSize.width(80, context),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${ApiKey.imagekey}/w780${data.cast![index].profilePath!}"),
                                          fit: BoxFit.cover)),
                                ),
                          Text(
                            data.cast![index].name!,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            data.cast![index].character!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column detailview(
      DetailModel data, bool mode, WidgetRef ref, BuildContext context) {
    // var generlistAsyncValue = ref.watch(genreList(width));
    // var generlist = generlistAsyncValue.whenData((value) => value).value;

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * double.infinity,
          height: ResponsiveSize.height(200, context),
          child: Image.network(
            "${ApiKey.imagekey}/w780/${data.backdropPath ?? data.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveSize.height(10, context),
            horizontal: ResponsiveSize.width(20, context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: ResponsiveSize.height(80, context),
                        width: ResponsiveSize.width(100, context),
                      ),
                      Positioned(
                        bottom: 1,
                        child: data.posterPath == null
                            ? Icon(
                                Icons.block,
                                color: mode ? Colors.white : Colors.black,
                                size: 40,
                              )
                            : Container(
                                height: ResponsiveSize.height(130, context),
                                width: ResponsiveSize.width(90, context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${ApiKey.imagekey}/w500/${data.posterPath!}"),
                                        fit: BoxFit.cover)),
                              ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ResponsiveSize.width(180, context),
                        child: Text(
                          data.title!,
                          style: TextStyle(
                              color: mode ? maincolor : Colors.black,
                              fontFamily: "Righteous",
                              fontSize: ResponsiveSize.width(16, context)),
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(10, context)),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: ResponsiveSize.width(150, context),
                            child: data.releaseDate != null
                                ? Text(
                                    DateFormat("yyyy/MMM/dd")
                                        .format(data.releaseDate!),
                                    style: TextStyle(
                                        color: mode ? maincolor : Colors.black,
                                        fontFamily: "Righteous",
                                        fontSize:
                                            ResponsiveSize.width(16, context)),
                                  )
                                : const Text(""),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: ResponsiveSize.width(16, context),
                              ),
                              Text(
                                "${data.voteAverage!.toStringAsFixed(1)}/10",
                                style: TextStyle(
                                    color: mode ? maincolor : Colors.black,
                                    fontFamily: "Righteous",
                                    fontSize:
                                        ResponsiveSize.width(16, context)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBoxsize.sizedboxh20(context),

              SizedBox(
                height: ResponsiveSize.height(40, context),
                width: ResponsiveSize.width(400, context),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.genres!.length,
                  itemBuilder: (context, index) {
                    return Text(data.genres![index].name!,
                        style: TextStyle(
                          color: mode ? maincolor : Colors.black,
                          fontFamily: "Righteous",
                          fontSize: ResponsiveSize.width(10, context),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Text(
                      "/",
                      style: TextStyle(
                          color: mode ? maincolor : Colors.black,
                          fontFamily: "Righteous",
                          fontSize: ResponsiveSize.width(10, context)),
                    );
                  },
                ),
              ),
              SizedBox(
                height: ResponsiveSize.width(4, context),
              ),
              const Divider(),
              Container(
                padding: EdgeInsets.all(ResponsiveSize.width(8, context)),
                child: Text(
                  data.overview!,
                  style: TextStyle(
                      color: mode ? maincolor : Colors.black,
                      fontFamily: "Righteous",
                      fontSize: ResponsiveSize.width(18, context)),
                ),
              ),
              Text(
                "Cast",
                style: TextStyle(
                    decorationThickness: 3,
                    decorationStyle: TextDecorationStyle.dashed,
                    decorationColor: mode ? maincolor : Colors.black,
                    decoration: TextDecoration.underline,
                    color: mode ? maincolor : Colors.black,
                    fontFamily: "Righteous",
                    fontSize: ResponsiveSize.width(18, context)),
              ),

              // SizedBox(
              //   height: 160,
              //   child: cast.when(
              //     data: (data) => buildcast(data, mode, sw, sh),
              //     error: (error, stackTrace) => Text(error.toString()),
              //     loading: () => const Center(
              //       child: CircularProgressIndicator(),
              //     ),
              //   ),
              // )
              SizedBox(
                height: ResponsiveSize.height(10, context),
              ),
            ],
          ),
        )
      ],
    );
  }

  // ListView buildcast(CastAndCrewModel data, bool mode, double sw, double sh) {
  //   return ListView.separated(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: data.cast!.length,
  //     shrinkWrap: true,
  //     physics: const BouncingScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       return Row(
  //         children: [
  //           SizedBox(
  //             height: 100,
  //             width: 60,
  //             child: data.cast![index].profilePath == null
  //                 ? const Icon(
  //                     Icons.person,
  //                     color: Colors.white,
  //                   )
  //                 : Image.network(
  //                     "${ApiKey.imagekey}/w500${data.cast![index].profilePath!}",
  //                     fit: BoxFit.cover,
  //                   ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 data.cast![index].name!,
  //                 style: TextStyle(
  //                     color: mode ? Colors.white : Colors.black,
  //                     fontFamily: "Righteous",
  //                     fontSize: sw * (14 / Responsive.width)),
  //               ),
  //               SizedBox(
  //                 width: sw * .4,
  //                 child: Text(
  //                   data.cast![index].character!,
  //                   style: TextStyle(
  //                       color: mode ? Colors.white : Colors.black,
  //                       fontFamily: "Righteous",
  //                       fontSize: sw * (10 / Responsive.width)),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //     separatorBuilder: (BuildContext context, int index) {
  //       return SizedBox(
  //         width: sw * (8 / Responsive.width),
  //       );
  //     },
  //   )ListView buildcast(CastAndCrewModel data, bool mode, double sw, double sh) {
  //   return ListView.separated(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: data.cast!.length,
  //     shrinkWrap: true,
  //     physics: const BouncingScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       return Row(
  //         children: [
  //           SizedBox(
  //             height: 100,
  //             width: 60,
  //             child: data.cast![index].profilePath == null
  //                 ? const Icon(
  //                     Icons.person,
  //                     color: Colors.white,
  //                   )
  //                 : Image.network(
  //                     "${ApiKey.imagekey}/w500${data.cast![index].profilePath!}",
  //                     fit: BoxFit.cover,
  //                   ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 data.cast![index].name!,
  //                 style: TextStyle(
  //                     color: mode ? Colors.white : Colors.black,
  //                     fontFamily: "Righteous",
  //                     fontSize: sw * (14 / Responsive.width)),
  //               ),
  //               SizedBox(
  //                 width: sw * .4,
  //                 child: Text(
  //                   data.cast![index].character!,
  //                   style: TextStyle(
  //                       color: mode ? Colors.white : Colors.black,
  //                       fontFamily: "Righteous",
  //                       fontSize: sw * (10 / Responsive.width)),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //     separatorBuilder: (BuildContext context, int index) {
  //       return SizedBox(
  //         width: sw * (8 / Responsive.width),
  //       );
  //     },
  //   );;
  // }
}
