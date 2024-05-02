import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/Layout_cubit/home-cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/Layout_cubit/home-state.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';
import 'package:sell_4_u/Features/payment/knet-screen.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/cache/cache_helper.dart';
import 'package:sell_4_u/core/helper/component/component.dart';
import 'package:sell_4_u/core/responsive_screen.dart';
import 'package:sell_4_u/core/video_detail.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../generated/l10n.dart';
import '../../../models/category_model.dart';
import '../../../models/coupon-model.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()
        ..getCategory()
        ..getUserData(id: CacheHelper.getData(key: 'uId')),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          var cubit = FeedsCubit.get(context);
          if (cubit.isLoading == false) {
            List<TextEditingController> controllers = [
              cubit.reasonController,
              cubit.detailController,
              cubit.descController,
              cubit.imageController,
              cubit.catController,
              cubit.locationController,
              cubit.locationController,
              cubit.priceController,
              cubit.titleController,
            ];

            for (var controller in controllers) {
              controller.clear();
            }
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return LayoutScreen();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);

          return NewWidgetMobile(
            cubit: cubit,
            state: state,
          );
        },
      ),
    );
  }
}

class NewWidgetMobile extends StatelessWidget {
  const NewWidgetMobile({
    super.key,
    required this.cubit,
    required this.state,
  });

  final FeedsCubit cubit;
  final FeedsState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveScreen.setColorTheme(
          Colors.white, ThemeData.dark().scaffoldBackgroundColor, context),
      appBar: AppBar(
        elevation: 0,
        leading: ResponsiveScreen.isMobile(context)
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 16,
                ),
              )
            : null,
        title: Text(
          S.of(context).postAd,
          style: FontStyleThame.textStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cubit.imageList.isEmpty && cubit.videoList.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: CacheHelper.getData(key: "isDark") == null
                          ? const Color.fromRGBO(242, 242, 242, 1)
                          : CacheHelper.getData(key: "isDark")
                              ? ThemeData.dark().scaffoldBackgroundColor
                              : const Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // cubit.pickImages();
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.rightSlide,
                                  title: 'Choose the way',
                                  desc: 'Photo Or Video',
                                  btnCancelOnPress: () {
                                    cubit.pickVideo();
                                  },
                                  btnCancelText: 'Video',
                                  btnCancelIcon: Icons.video_camera_back,
                                  btnCancelColor: Colors.grey,
                                  btnOkColor: Colors.grey,
                                  btnOkIcon: Icons.image,
                                  btnOkText: 'Image',
                                  btnOkOnPress: () {
                                    cubit.pickImages();
                                  }).show();
                            },
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                color:
                                    CacheHelper.getData(key: "isDark") == null
                                        ? const Color.fromRGBO(242, 242, 242, 1)
                                        : CacheHelper.getData(key: "isDark")
                                            ? ThemeData.dark()
                                                .scaffoldBackgroundColor
                                            : const Color.fromRGBO(
                                                242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Image(
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/sales-b43bd.appspot.com/o/image-removebg-preview%20(2).png?alt=media&token=240ba74f-db07-4bdc-a340-f8b10686ae1f',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: CacheHelper.getData(key: "isDark") == null
                                  ? const Color.fromRGBO(242, 242, 242, 1)
                                  : CacheHelper.getData(key: "isDark")
                                      ? ThemeData.dark().scaffoldBackgroundColor
                                      : const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: cubit.imageController,
                                onTap: () {},
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  errorStyle: FontStyleThame.textStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please select at least one image';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (cubit.imageList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider(
                    items: cubit.imageList.asMap().entries.map(
                      (e) {
                        final index = e.key;
                        final imageUrl = e.value;
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: CacheHelper.getData(key: "isDark") == null
                                ? const Color.fromRGBO(242, 242, 242, 1)
                                : CacheHelper.getData(key: "isDark")
                                    ? ThemeData.dark().scaffoldBackgroundColor
                                    : const Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Stack(
                                  children: [
                                    Image(
                                      height: 170,
                                      image: FileImage(imageUrl),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        print("Error loading image: $error");
                                        return Placeholder(); // Placeholder widget or some other fallback UI
                                      },
                                    ),
                                    PopupMenuButton<int>(
                                      onCanceled: () {
                                        Navigator.of(context);
                                      },
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide.none),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 1,
                                          onTap: () {
                                            cubit.pickImages();
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'Add image',
                                                style: FontStyleThame.textStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const Spacer(),
                                              const Icon(Icons.plus_one)
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: InkWell(
                                            onTap: () {
                                              cubit.deleteImage(
                                                  value: imageUrl);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "remove",
                                                  style:
                                                      FontStyleThame.textStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Icon(IconlyLight.delete)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      icon: const CircleAvatar(
                                        child: Icon(
                                          Icons.more_horiz,
                                        ),
                                      ),
                                      offset: const Offset(0, 20),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ColorStyle.gray,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.image),
                                          Text(
                                              '${index + 1}/${cubit.imageList.length}')
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              if (cubit.videoList.isNotEmpty)
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        child: VideoFileApp(
                          video: cubit.videoList[0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            cubit.deleteImage(value: cubit.videoList[0]);
                          },
                          icon: Icon(IconlyLight.delete),
                        ),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CatDropDown(
                  model: cubit.catModel,
                  cubit: cubit,
                ),
              ),
              if (cubit.subCatModel.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CatDropDownSub(
                    model: cubit.subCatModel,
                    cubit: cubit,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormWidget(
                    maxLines: 2,
                    keyboardType:
                    TextInputType.text,
                    emailController: cubit.titleController,
                    prefixIcon: const Icon(
                      Icons.title,
                      size: 15,
                    ),
                    hintText: 'Please write your Name of product',
                    validator: 'Please write your Name of product',
                    obscureText: false,
                    icon: false,
                    enabled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormWidget(
                    maxLines: 2,
                    emailController: cubit.reasonController,
                    prefixIcon: const Icon(
                      Icons.access_time_filled,
                      size: 15,
                    ),
                    hintText: S.of(context).reasonAdd,
                    validator: S.of(context).reasonAdd,
                    obscureText: false,
                    icon: false,
                    enabled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Text('Choose type of advertise'),
                      Spacer(),
                      Switch(
                        value: cubit.isOffer,
                        onChanged: (value) {
                          cubit.changeOfferType();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormWidget(
                    maxLines: 2,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    emailController: cubit.priceController,
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      size: 15,
                    ),
                    hintText: 'Please write your price',
                    validator: 'Please write your price',
                    obscureText: false,
                    icon: false,
                    enabled: true,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 90,
                  child: TextFormWidget(
                    maxLines: 2,
                    emailController: cubit.detailController,
                    prefixIcon: const Icon(
                      Icons.details,
                      size: 15,
                    ),
                    hintText: S.of(context).details,
                    validator: S.of(context).details,
                    obscureText: false,
                    icon: false,
                    enabled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 90,
                  child: TextFormWidget(
                    maxLines: 2,
                    emailController: cubit.descController,
                    prefixIcon: const Icon(
                      Icons.description,
                      size: 15,
                    ),
                    hintText: S.of(context).descriptionAdd,
                    validator: S.of(context).descriptionAdd,
                    obscureText: false,
                    icon: false,
                    enabled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 111,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  cubit.latitude ?? 20.0,
                                  cubit.longitude ?? 20.0,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                                width: MediaQuery.sizeOf(context).width * .6,
                                child: TextFormField(
                                  controller: cubit.locationController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please pressed on bottom to get current Location';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        'Please pressed on bottom to get current Location',
                                    enabledBorder: InputBorder.none,
                                    hintStyle: FontStyleThame.textStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    errorStyle: FontStyleThame.textStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                child: (state is GetLocationLoading)
                                    ? CircularProgressIndicator()
                                    : IconButton(
                                        onPressed: () {
                                          cubit.getCurrentPosition(context);
                                        },
                                        icon: const Icon(
                                          IconlyLight.location,
                                        ),
                                      ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyle.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                    ),
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PlanChoose(
                              cubit: cubit,
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          IconlyLight.upload,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        cubit.isLoading == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                S.of(context).createPost,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanChoose extends StatefulWidget {
  const PlanChoose({
    super.key,
    required this.cubit,
  });

  final FeedsCubit cubit;

  @override
  State<PlanChoose> createState() => _PlanChooseState();
}

class _PlanChooseState extends State<PlanChoose> {
  bool isBasic = false;
  bool isPlan = false;
  bool isExtra = false;
  bool isSuper = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getCoupons()
        ..getSubscriptions(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: AlertDialog(
              title: Text(
                'Choose on of suggested plans',
                style: FontStyleThame.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              content: homeCubit.subscriptions.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 111,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  isBasic = true;
                                  isExtra = false;
                                  isSuper = false;
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: CircleAvatar(
                                            radius: 9,
                                            foregroundColor: Colors.black38,
                                            child: CircleAvatar(
                                              radius: 7,
                                              backgroundColor: isBasic
                                                  ? ColorStyle.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          homeCubit.subscriptions.first.name ??
                                              'Basic',
                                          style: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          homeCubit.subscriptions.first.price
                                                  .toString() ??
                                              r'7.5 $',
                                          style: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.black12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 12, start: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Icon(
                                              IconlyLight.time_circle,
                                              size: 19,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Pushed to product category for 30 Days',
                                              maxLines: 1,
                                              style: FontStyleThame.textStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontColor: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  isBasic = false;
                                  isExtra = true;
                                  isSuper = false;
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: CircleAvatar(
                                            radius: 9,
                                            foregroundColor: Colors.black38,
                                            child: CircleAvatar(
                                              radius: 7,
                                              backgroundColor: isExtra
                                                  ? ColorStyle.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          homeCubit.subscriptions[1].name ??
                                              'Extra',
                                          style: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          homeCubit.subscriptions[1].price
                                                  .toString() ??
                                              r'13 $',
                                          style: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.black12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 12, start: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Icon(
                                              IconlyLight.time_circle,
                                              size: 19,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Pushed to product category for 30 Days',
                                              maxLines: 1,
                                              style: FontStyleThame.textStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 12, start: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Icon(
                                              Icons.move_up,
                                              size: 19,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Pin in most popular for 30 Days',
                                              maxLines: 1,
                                              style: FontStyleThame.textStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  isBasic = false;
                                  isExtra = false;
                                  isSuper = true;
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: CircleAvatar(
                                            radius: 9,
                                            foregroundColor: Colors.black38,
                                            child: CircleAvatar(
                                              radius: 7,
                                              backgroundColor: isSuper
                                                  ? ColorStyle.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          homeCubit.subscriptions[2].name ??
                                              'Super',
                                          style: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          homeCubit.subscriptions[2].price
                                                  .toString() ??
                                              r'20 $',
                                          style: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.black12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 12, start: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Icon(
                                              IconlyLight.time_circle,
                                              size: 19,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Pushed to product category for 30 Days',
                                              maxLines: 1,
                                              style: FontStyleThame.textStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 12, start: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Icon(
                                              Icons.move_up,
                                              size: 19,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Pin in most popular for 30 Days',
                                              maxLines: 1,
                                              style: FontStyleThame.textStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 12, start: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Icon(
                                              Icons.notifications_active,
                                              size: 19,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Send notifications to all user',
                                              maxLines: 1,
                                              style: FontStyleThame.textStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (homeCubit.coupons.isNotEmpty)
                            SizedBox(
                              height: 12,
                            ),
                          if (homeCubit.coupons.isNotEmpty)
                            SizedBox(
                              height: 44,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(242, 242, 242, 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: homeCubit.controller,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'please enter coupon code';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "enter coupon code",
                                      enabledBorder: InputBorder.none,
                                      hintStyle: FontStyleThame.textStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      errorStyle: FontStyleThame.textStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              processPayment(
                                context,
                                isBasic,
                                isSuper,
                                isExtra,
                                homeCubit,
                                widget.cubit,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorStyle.primaryColor,
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 40),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: (RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                            ),
                            child: Text(
                              'Submit',
                              style: FontStyleThame.textStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          );
        },
      ),
    );
  }

  findCoupon(dynamic data, String name) {
    for (var element in data) {
      if (element.name == name) {
        return element;
      }
    }
    return null;
  }

  void processPayment(
    BuildContext context,
    bool isBasic,
    bool isSuper,
    bool isExtra,
    HomeCubit homeCubit,
    FeedsCubit feedsCubit,
  ) {
    bool isValidCoupon =
        homeCubit.coupons.isNotEmpty && homeCubit.controller.text.isNotEmpty;

    CouponModel? coupon;
    print('processPayment');

    if (isValidCoupon) {
      coupon = findCoupon(homeCubit.coupons, homeCubit.controller.text);
      if (coupon == null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            backgroundColor: Colors.amber,
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 90,
            ),
            message: 'Coupon not found',
          ),
        );
      } else {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: 'Coupon code is matched',
          ),
        );
      }
    }

    int amountToPay = 0;
    if (isBasic) {
      print('basic plan');
      amountToPay = isValidCoupon
          ? homeCubit.subscriptions.first.price - coupon!.price
          : homeCubit.subscriptions.first.price;
    } else if (isSuper) {
      print('super plan');
      amountToPay = isValidCoupon
          ? homeCubit.subscriptions.elementAt(1).price - coupon!.price
          : homeCubit.subscriptions.elementAt(1).price;
    } else if (isExtra) {
      print('extra plan');
      amountToPay = isValidCoupon
          ? homeCubit.subscriptions.last.price - coupon!.price
          : homeCubit.subscriptions.last.price;
    }

    paymentKnet(
      amountController: amountToPay.toString(),
      phoneController: feedsCubit.userModel!.phone.toString(),
      nameController: feedsCubit.userModel!.name.toString(),
      context: context,
      emailController: feedsCubit.userModel!.email.toString(),
      cubit: feedsCubit,
      coponId: isValidCoupon ? coupon!.id! : '',
    );
  }
}

class CatDropDown extends StatefulWidget {
  const CatDropDown({
    super.key,
    required this.model,
    required this.cubit,
  });

  final List<CategoryModel> model;
  final FeedsCubit cubit;

  @override
  State<CatDropDown> createState() => _CatDropDownState();
}

class _CatDropDownState extends State<CatDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: CacheHelper.getData(key: "isDark") == null
            ? const Color.fromRGBO(242, 242, 242, 1)
            : CacheHelper.getData(key: "isDark")
                ? ThemeData.dark().scaffoldBackgroundColor
                : const Color.fromRGBO(242, 242, 242, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: widget.cubit.catController,
          onTap: () {
            showCategoryPicker(context);
          },
          decoration: InputDecoration(
            hintStyle: FontStyleThame.textStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            hintText: widget.cubit.catValueString,
            enabledBorder: InputBorder.none,
            errorStyle: FontStyleThame.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          validator: (test) {
            if (widget.cubit.catController.text.isEmpty) {
              return 'Please select a category';
            }

            return null;
          },
        ),
      ),
    );
  }

  List<CategoryModel> list = [];

  void showCategoryPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: widget.cubit.catController,
                onChanged: (va) {
                  setState(() {
                    list = widget.model
                        .where((element) => element.categoryName!
                            .toLowerCase()
                            .contains(va.toLowerCase()))
                        .toList();
                  });
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintStyle: FontStyleThame.textStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: widget.cubit.catValueString,
                  enabledBorder: InputBorder.none,
                  errorStyle: FontStyleThame.textStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (test) {
                  if (widget.cubit.catController.text.isEmpty) {
                    return 'Please select a category';
                  }

                  return null;
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.isEmpty ? widget.model.length : list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(list.isEmpty
                        ? widget.model[index].categoryName!
                        : list[index].categoryName!),
                    onTap: () {
                      String selectedCategory = list.isEmpty
                          ? widget.model[index].categoryName!
                          : list[index].categoryName!;
                      widget.cubit.catValueStringCreate(
                        value: selectedCategory,
                        index: index,
                      );

                      widget.cubit.getSubCategory(widget.cubit.catIdString!);

                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CatDropDownSub extends StatefulWidget {
  const CatDropDownSub({
    super.key,
    required this.model,
    required this.cubit,
  });

  final List<CategoryModel> model;
  final FeedsCubit cubit;

  @override
  State<CatDropDownSub> createState() => _CatDropDownSubState();
}

class _CatDropDownSubState extends State<CatDropDownSub> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: CacheHelper.getData(key: "isDark") == null
            ? const Color.fromRGBO(242, 242, 242, 1)
            : CacheHelper.getData(key: "isDark")
                ? ThemeData.dark().scaffoldBackgroundColor
                : const Color.fromRGBO(242, 242, 242, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: widget.cubit.catSubController,
          onTap: () {
            showCategoryPicker(context);
          },
          decoration: InputDecoration(
            hintStyle: FontStyleThame.textStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            hintText: widget.cubit.catSubController.text.isEmpty
                ? 'Please select sub category'
                : widget.cubit.catSubController.text,
            enabledBorder: InputBorder.none,
            errorStyle: FontStyleThame.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          validator: (test) {
            if (widget.cubit.catSubController.text.isEmpty) {
              return 'Please select sub category';
            }

            return null;
          },
        ),
      ),
    );
  }

  List<CategoryModel> list = [];

  void showCategoryPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: widget.cubit.catSubController,
                onChanged: (va) {
                  setState(() {
                    list = widget.model
                        .where((element) => element.categoryName!
                            .toLowerCase()
                            .contains(va.toLowerCase()))
                        .toList();
                  });
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintStyle: FontStyleThame.textStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: widget.cubit.catValueString,
                  enabledBorder: InputBorder.none,
                  errorStyle: FontStyleThame.textStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (test) {
                  if (widget.cubit.catController.text.isEmpty) {
                    return 'Please select a category';
                  }

                  return null;
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.isEmpty ? widget.model.length : list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(list.isEmpty
                        ? widget.model[index].categoryName!
                        : list[index].categoryName!),
                    onTap: () {
                      String selectedCategory = list.isEmpty
                          ? widget.model[index].categoryName!
                          : list[index].categoryName!;
                      print(selectedCategory);
                      print('*******************************');
                      setState(() {
                        widget.cubit.catSubController = TextEditingController(text: selectedCategory);

                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
