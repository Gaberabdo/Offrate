import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_cubit.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant.dart';
import '../../../../core/helper/cache/cache_helper.dart';
import '../../../../core/helper/component/component.dart';
import '../../../../generated/l10n.dart';
import '../../../Home-feature/view/screens/home/feeds_details.dart';
import '../../../Home-feature/view/widget/all_most_popular_widget/all_most_popular_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getListSearch(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final settingCubit = BlocProvider.of<SettingCubit>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).search,
                style: FontStyleThame.textStyle(),
              ),
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
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormWidget(
                      emailController: searchController,
                      prefixIcon: const Icon(
                        IconlyLight.search,
                        size: 15,
                      ),
                      onChanged: (value) {
                        settingCubit.searchInList(value); // Trigger search
                      },
                      hintText: S.of(context).search,
                      validator: '',
                      obscureText: false,
                      icon: false,
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is LoadingGetCategoriesData)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 5,
                    ),
                    if (state is SuccessGetCategoriesData)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: CacheHelper.getData(key: "isDark") == null
                                    ? const Color.fromRGBO(242, 242, 242, 1)
                                    : CacheHelper.getData(key: "isDark")
                                    ? Colors.white10
                                    : const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.sizeOf(context).width / 4,
                                      (state.categoriesModel[index].images!
                                              .isEmpty)
                                          ? "https://via.placeholder.com/700"
                                          : state.categoriesModel[index].images!
                                              .first,
                                      scale: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.categoriesModel[index]
                                              .reasonOfOffer!,
                                          style: FontStyleThame.textStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          state.categoriesModel[index].cat!,
                                          style: FontStyleThame.textStyle(
                                            fontSize: 14,
                                            fontColor: Colors.black45,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.categoriesModel[index].price! +
                                              r" EGP",
                                          style: FontStyleThame.textStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontColor: ColorStyle.primaryColor,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return HomeFeedsDetails(
                                                    value: state
                                                        .categoriesModel[index]
                                                        .view,
                                                    uid: state
                                                        .categoriesModel[index]
                                                        .uId!,
                                                    productId: settingCubit
                                                        .searchIdes[index],
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
                                                          begin: begin,
                                                          end: end)
                                                      .chain(CurveTween(
                                                          curve: curve));
                                                  var offsetAnimation =
                                                      animation.drive(tween);
                                                  return SlideTransition(
                                                    position: offsetAnimation,
                                                    child: child,
                                                  );
                                                },
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 500),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorStyle.primaryColor,
                                            foregroundColor: Colors.white,
                                            elevation: 3,
                                            shape: (RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            )),
                                          ),
                                          child: Text(
                                            "View",
                                            style: FontStyleThame.textStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: state.categoriesModel.length,
                      ),
                    if (state is ErrorGetCategoriesData)
                      Center(
                        child: Image.network(Constant.imageNotFound),
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
