import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/responsive_screen.dart';
import 'package:shimmer/shimmer.dart';

import 'feeds_details.dart';

class BannerCat extends StatelessWidget {
  const BannerCat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()..getCategory(),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          var cubit = FeedsCubit.get(context);

          if (state is GetCategorySuccess) {
            cubit.catIdString = cubit.catModelIdes.first;
            for (var element in cubit.catModel) {
              element.isSelected = false;
            }
            cubit.catModel[0].isSelected = true;

            cubit.getCategoryDetails(cubit.catModelIdes.first);
          }
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          return Scaffold(
            backgroundColor: ResponsiveScreen.setColorTheme(Colors.white,
                ThemeData.dark().scaffoldBackgroundColor, context),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  (cubit.catModel.isNotEmpty)
                      ? SizedBox(
                          height: 60,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    for (var element in cubit.catModel) {
                                      element.isSelected = false;
                                    }
                                    cubit.catModel[index].isSelected =
                                        !cubit.catModel[index].isSelected!;

                                    cubit.getCategoryDetails(
                                        cubit.catModelIdes[index]);
                                    cubit.catIdString =
                                        cubit.catModelIdes[index];
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: cubit.catModel[index]
                                                    .isSelected ==
                                                true
                                            ? ColorStyle.primaryColor
                                            : ResponsiveScreen.setColorTheme(
                                                Colors.white,
                                                Colors.white10,
                                                context),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          style: cubit.catModel[index]
                                                      .isSelected ==
                                                  true
                                              ? BorderStyle.none
                                              : BorderStyle.solid,
                                          color: Colors.black,
                                          width: .5,
                                        )),
                                    child: Center(
                                      child: Text(
                                        cubit.catModel[index].categoryName!,
                                        style: FontStyleThame.textStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          fontColor: cubit.catModel[index]
                                                      .isSelected ==
                                                  true
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: cubit.catModel.length,
                          ),
                        )
                      : SizedBox(
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade500,
                                    child: Container(
                                      height: 20,
                                      width: 120,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 10,
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  (state is GetCategoryLoading)
                      ? GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisExtent: 250.0,
                            maxCrossAxisExtent: 300,
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
                          itemCount: 10,
                        )
                      : cubit.getCategoryDetailsModel.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 250.0,
                                maxCrossAxisExtent: 300,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return HomeFeedsDetails(
                                              productId: cubit
                                                  .catModelDetailsIdes[index],
                                              value: cubit
                                                  .getCategoryDetailsModel[
                                                      index]
                                                  .view,
                                              uid: cubit
                                                  .getCategoryDetailsModel[
                                                      index]
                                                  .uId!,
                                            );
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = const Offset(1.0, 0.0);
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
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        color: ResponsiveScreen.setColorTheme(
                                          Colors.white,
                                          Colors.black12,
                                          context,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x14000000),
                                            blurRadius: 10,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              children: [
                                                Image.network(
                                                  (cubit
                                                          .getCategoryDetailsModel[
                                                              index]
                                                          .images!
                                                          .isEmpty)
                                                      ? "https://via.placeholder.com/700"
                                                      : cubit
                                                          .getCategoryDetailsModel[
                                                              index]
                                                          .images!
                                                          .first,
                                                  height: 190,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                                Image(
                                                  height: 60,
                                                  width: 85,
                                                  //fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'assets/images/offerta.png'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, right: 4, top: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  IconlyLight.location,
                                                  size: 14,
                                                  color:
                                                      ColorStyle.primaryColor,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    cubit
                                                        .getCategoryDetailsModel[
                                                            index]
                                                        .location!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FontStyleThame
                                                        .textStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      fontColor:
                                                          ResponsiveScreen
                                                              .setColorTheme(
                                                        Colors.black,
                                                        Colors.white,
                                                        context,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  ',',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      FontStyleThame.textStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontColor: ColorStyle.gray,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.attach_money,
                                                  size: 14,
                                                  color:
                                                      ColorStyle.primaryColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    cubit
                                                        .getCategoryDetailsModel[
                                                            index]
                                                        .price!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FontStyleThame
                                                        .textStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontColor: ColorStyle
                                                          .primaryColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: cubit.getCategoryDetailsModel.length,
                            )
                          : Center(
                              child: Image.network(
                                width: 600,
                                height: 600,
                                Constant.imageNotFound,
                              ),
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
