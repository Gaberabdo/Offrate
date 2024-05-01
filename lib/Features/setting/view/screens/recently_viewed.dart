import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_cubit.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant.dart';
import '../../../../generated/l10n.dart';
import '../../../Home-feature/view/screens/home/feeds_details.dart';
import '../../../Home-feature/view/widget/all_most_popular_widget/all_most_popular_widget.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getFavorite(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SettingCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 16,
                ),
              ),
              title: Text(
                S.of(context).my_favorites,
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: (state is LoadingGetFavoriteData)
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
                : cubit.favoriteModel.isNotEmpty
                    ? GridView.builder(
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
                              print(cubit.favoriteModel[index].images);
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return HomeFeedsDetails(
                                      value: cubit.favoriteModel[index].view,
                                      uid: cubit.favoriteModel[index].uId!,
                                      productId: cubit.faveId[index],
                                    );
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end)
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
                            child: MostPopular(
                              model: cubit.favoriteModel[index],
                            ),
                          );
                        },
                        itemCount: cubit.favoriteModel.length,
                      )
                    : Center(
                        child: Image.network(Constant.imageNotFound),
                      ),
          );
        },
      ),
    );
  }
}
