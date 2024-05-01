import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/Features/Home-feature/models/category_model.dart';
import 'package:sell_4_u/core/responsive_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constant.dart';
import 'feeds_details.dart';

class CatDetails extends StatelessWidget {
  const CatDetails({
    super.key,
    required this.categoryModel,
    required this.catModelIds,
  });

  final CategoryModel categoryModel;
  final String catModelIds;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()
        ..init(
          categoryModel,
          catModelIds,
        ),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);

          return Scaffold(
            backgroundColor: ResponsiveScreen.setColorTheme(Colors.white,
                ThemeData.dark().scaffoldBackgroundColor, context),
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
                categoryModel.categoryName.toString(),
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: BlocConsumer<FeedsCubit, FeedsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (categoryModel.subCat != null) {
                  if (categoryModel.subCat!) {
                    return (state is GetCategoryLoading)
                        ? GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 250.0,
                              maxCrossAxisExtent: 250.0,
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
                                    highlightColor: Colors.grey.shade600,
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
                        : cubit.subCatModel.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 250.0,
                                  maxCrossAxisExtent: 250,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return CatDetails(
                                                categoryModel:
                                                    cubit.subCatModel[index],
                                                catModelIds: cubit
                                                    .subCatModel[index].id
                                                    .toString(),
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
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomEnd,
                                                  children: [
                                                    Image.network(
                                                      (cubit.subCatModel[index]
                                                              .image!.isEmpty)
                                                          ? "https://via.placeholder.com/700"
                                                          : cubit
                                                              .subCatModel[
                                                                  index]
                                                              .image!,
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
                                                  ]),
                                            ),
                                            Text(cubit
                                                .subCatModel[index].categoryName
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: cubit.subCatModel.length,
                              )
                            : Center(
                                child: Image.network(Constant.imageNotFound),
                              );
                  } else {
                    return (state is GetCategoryLoading)
                        ? GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                      SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 250.0,
                        maxCrossAxisExtent: 250.0,
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
                              highlightColor: Colors.grey.shade600,
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
                      gridDelegate:
                      SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 250.0,
                        maxCrossAxisExtent: 250,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                      secondaryAnimation) {
                                    return HomeFeedsDetails(
                                      uid: cubit
                                          .getCategoryDetailsModel[
                                      index]
                                          .uId!,
                                      value: cubit
                                          .getCategoryDetailsModel[
                                      index]
                                          .view!,
                                      productId: cubit
                                          .catModelDetailsIdes[index],
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
                                        ]),
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
                                              fontColor:
                                              ResponsiveScreen
                                                  .setColorTheme(
                                                Colors.black,
                                                Colors.white,
                                                context,
                                              ),
                                              fontSize: 14,
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
                      child: Image.network(Constant.imageNotFound),
                    );
                  }
                } else {
                  return (state is GetCategoryLoading)
                      ? GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisExtent: 250.0,
                            maxCrossAxisExtent: 250.0,
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
                                  highlightColor: Colors.grey.shade600,
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
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 250.0,
                                maxCrossAxisExtent: 250,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {

                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return HomeFeedsDetails(
                                              uid: cubit
                                                  .getCategoryDetailsModel[
                                                      index].uId!,
                                              value: cubit.getCategoryDetailsModel[index].view!,
                                              productId: cubit.catModelDetailsIdes[index],
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
                                                ]),
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
                                                      fontColor:
                                                          ResponsiveScreen
                                                              .setColorTheme(
                                                        Colors.black,
                                                        Colors.white,
                                                        context,
                                                      ),
                                                      fontSize: 14,
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
                              child: Image.network(Constant.imageNotFound),
                            );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
