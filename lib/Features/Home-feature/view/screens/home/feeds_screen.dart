import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';

import 'package:sell_4_u/Features/Home-feature/view/screens/home/cat_details.dart';
import 'package:sell_4_u/Features/ad/banner-screen.dart';
import 'package:sell_4_u/Features/ad/interstital-screen.dart';
import 'package:sell_4_u/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constant.dart';
import '../../../../../core/responsive_screen.dart';
import '../../../../ad/Ad-manger.dart';
import '../../widget/all_cat_widget/all_cat_widget.dart';
import '../../widget/all_most_popular_widget/all_most_popular_widget.dart';
import 'feeds_details.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()
        ..getCategory()
        ..mostPopular(),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          return Scaffold(
            backgroundColor: ResponsiveScreen.setColorTheme(Colors.white,
                ThemeData.dark().scaffoldBackgroundColor, context),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (!cubit.isGetCategoryLoading)
                        ? SizedBox(
                            height: 130,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade500,
                                    child: CircleAvatar(
                                      radius: 40,
                                    ),
                                  ),
                                );
                              },
                              itemCount: 12,
                            ),
                          )
                        : SizedBox(
                            height: 130,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return CatDetails(
                                            categoryModel:
                                                cubit.catModel[index],
                                            catModelIds:
                                                cubit.catModelIdes[index],
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AllCategory(
                                      model: cubit.catModel[index],
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.catModel.length,
                            ),
                          ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ResponsiveScreen.setColorTheme(
                              ColorStyle.gray,
                              Colors.black,
                              context,
                            ),
                            width: .5,
                          )),
                      child: BannerScreen(),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      S.of(context).mostP,
                      style: FontStyleThame.textStyle(
                        fontColor: ColorStyle.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    (cubit.mostPopularModel.isEmpty)
                        ? GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 300.0,
                              maxCrossAxisExtent: 240.0,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade500,
                                    child: Card(
                                      elevation: 3,
                                      shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      child: const SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 12,
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 310.0,
                              maxCrossAxisExtent: 240.0,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(cubit.mostPopularModel[index].images);

                                  AdManger.loadInterstitialAd();
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return HomeFeedsDetails(
                                          uid: cubit
                                              .mostPopularModel[index]
                                              .uId!,
                                          value: cubit
                                              .mostPopularModel[index]
                                              .view,
                                          productId: cubit
                                              .mostPopularIdes[index],
                                        );
                                      },
                                      transitionsBuilder: (context,
                                          animation,
                                          secondaryAnimation,
                                          child) {
                                        var begin =
                                        const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(
                                            CurveTween(curve: curve));
                                        var offsetAnimation =
                                        animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(
                                          milliseconds: 500),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: MostPopular(
                                  model: cubit.mostPopularModel[index],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: cubit.mostPopularModel.length,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
