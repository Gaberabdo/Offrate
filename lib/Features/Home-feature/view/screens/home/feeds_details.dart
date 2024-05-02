import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/Features/Home-feature/models/product_model.dart';
import 'package:sell_4_u/Features/comment/controller/Commet_cubit/comment_cubit.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/helper/cache/cache_helper.dart';
import '../../../../../core/responsive_screen.dart';
import '../../../../../core/video_detail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../comment/view/screens/get_comment.dart';

class HomeFeedsDetails extends StatelessWidget {
  const HomeFeedsDetails({
    super.key,
    required this.productId,
    required this.uid,
    required this.value,
  });

  final String uid;
  final String productId;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeedsCubit()
            ..getUserData(id: uid)
            ..updateValue(productId: productId, value: value)
            ..getDetailsProData(
              id: productId,
            ),
        ),
        BlocProvider(
          create: (context) => CommentCubit()..getComment(productId: productId),
        ),
      ],
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          // TODO: implement listener


        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          ProductModel modelDetails = cubit.modelDetails;
          print(modelDetails.toMap());


          if (ResponsiveScreen.isMobile(context)) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          if (modelDetails.images != null)
                            if (modelDetails.images!.length > 0)
                              CarouselSlider(
                                items: modelDetails.images!.asMap().entries.map(
                                  (e) {
                                    final index = e.key;
                                    final imageUrl = e.value;
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            242, 242, 242, 1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        children: [
                                          Image(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.cover,
                                            height: 300,
                                            width: double.infinity,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 50,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: ColorStyle.gray,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.image),
                                                    Text(
                                                        '${index + 1}/${modelDetails.images!.length}')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                                options: CarouselOptions(
                                  height: 300,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: false,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                          if (modelDetails.images != null)
                            if (modelDetails.images!.length == 1)
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        modelDetails.images!.first),
                                    fit: BoxFit.cover,
                                    height: 300,
                                    width: double.infinity,
                                  ),
                                  Row(
                                    children:
                                    [
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
                                                 Icon(Icons.image,
                                                  color: CacheHelper.getData(key: 'isDark')?Colors.blue:Colors.grey,
                                                ),
                                                Text(
                                                    '${1}/${modelDetails.images!.length}',style:
                                                    TextStyle(color: CacheHelper.getData(key: 'isDark')?Colors.blue:Colors.black),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Image(
                                        height: 60,
                                        width: 85,
                                        //fit: BoxFit.fill,
                                        image:AssetImage('assets/images/offerta.png'),
                                      ),
                                    ]
                                  ),


                                ],
                              ),

                          Row(
                            children: [
                              IconButton(
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
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  cubit.updateValueFavBool();
                                  cubit.updateValueFav(
                                      value: modelDetails,
                                      productId: productId);
                                },
                                icon: Icon(
                                  cubit.isFav == true
                                      ? IconlyBold.heart
                                      : IconlyLight.heart,
                                  color: cubit.isFav == true
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  Share.share(
                                    "🌟 Exciting news! Introducing ${modelDetails.cat} - your new go-to solution for ${modelDetails.description}.  🚀 Try it now and experience the difference! #Innovation #ProductivityBoost",
                                    subject: 'Check out this offer!',
                                  );
                                },
                                icon: Icon(
                                  Icons.share,

                                  color:Colors.blue,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (modelDetails.video != null)
                        if(modelDetails.video!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: VideoStringApp(
                                video: modelDetails.video!,
                              ),
                            ),
                          ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              modelDetails.title ?? 'Name of product',
                              style: FontStyleThame.textStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              modelDetails.cat ?? 'Category',
                              style: FontStyleThame.textStyle(
                                fontSize: 20,

                                fontColor: Colors.blue,

                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              value.toString(),
                              style: FontStyleThame.textStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Views',
                              style: FontStyleThame.textStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.timelapse_outlined,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              transform(modelDetails.time ??
                                  'Tue Mar 29 2024 16:25:43 GMT+0530 (IST)'),
                              style: FontStyleThame.textStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              IconlyLight.location,
                              size: 14,
                              color: ColorStyle.primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                modelDetails.location ?? 'location',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyleThame.textStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              ',',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: FontStyleThame.textStyle(
                                fontWeight: FontWeight.w600,
                                fontColor: ColorStyle.gray,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.bar_chart,
                              size: 14,
                              color: ColorStyle.primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                modelDetails.reasonOfOffer ?? 'reason',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyleThame.textStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              ',',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: FontStyleThame.textStyle(
                                fontWeight: FontWeight.w600,
                                fontColor: ColorStyle.gray,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.attach_money,
                              size: 14,
                              color: ColorStyle.primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                modelDetails.price ?? 'price',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyleThame.textStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(cubit.userModel ==
                                      null
                                  ? "https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740&t=st=1710334520~exp=1710335120~hmac=f053daa6a74128973e2f7512cd8b6eaae51a0716ece0866a6b355e1c900a61e6"
                                  : cubit.userModel!.image!),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.userModel == null
                                      ? "user"
                                      : cubit.userModel!.name!,
                                  style: FontStyleThame.textStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    
                                  ),
                                ),
                                Text(
                                  "Owner",
                                  style: FontStyleThame.textStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,

                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                cubit.makePhoneCall(
                                    phone: cubit.userModel!.phone!);
                              },
                              color: ColorStyle.primaryColor,
                              icon: const Icon(
                                IconlyLight.call,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.openWhatsApp(
                                    phone: cubit.userModel!.phone!);
                              },
                              color: const Color.fromRGBO(37, 211, 102, 1),
                              icon: const Icon(
                                IconlyLight.chat,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.of(context).description,
                          style: FontStyleThame.textStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final textSpan = TextSpan(
                              text: modelDetails.description ?? 'description',
                              style: FontStyleThame.textStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,

                              ),
                            );
                            final textPainter = TextPainter(
                              text: textSpan,
                              textDirection: TextDirection.ltr,
                              maxLines: 3,
                            );
                            textPainter.layout(maxWidth: constraints.maxWidth);
                            final isTextOverflowing =
                                textPainter.didExceedMaxLines;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  textSpan,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                ),
                                if (isTextOverflowing) // Add message if text exceeds three lines
                                  const Text(
                                    '...',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Location",
                          style: FontStyleThame.textStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,

                          ),
                        ),
                      ),
                      if (modelDetails.lan != null && modelDetails.lat != null)
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: 300,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(12),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  zoom: 15.0,
                                  target: LatLng(
                                    modelDetails.lan!,
                                    modelDetails.lat!,
                                  ),
                                ),
                                buildingsEnabled: true,
                                compassEnabled: true,
                                myLocationEnabled: true,
                                indoorViewEnabled: true,
                                mapToolbarEnabled: true,
                                myLocationButtonEnabled: true,
                                zoomGesturesEnabled: true,
                                onMapCreated: (controller) {},
                              ),
                            ),
                          ),
                        ),
                      if (modelDetails.lan == null && modelDetails.lat == null)
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: 300,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(12),
                              child: GoogleMap(
                                mapType: MapType.hybrid,
                                initialCameraPosition: const CameraPosition(
                                  zoom: 10,
                                  target: LatLng(
                                    30,
                                    20,
                                  ),
                                ),
                                buildingsEnabled: true,
                                compassEnabled: true,
                                myLocationEnabled: true,
                                indoorViewEnabled: true,
                                mapToolbarEnabled: true,
                                myLocationButtonEnabled: true,
                                onMapCreated: (controller) {},
                              ),
                            ),
                          ),
                        ),
                      if (modelDetails.fave == true)
                        BlocConsumer<CommentCubit, CommentState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            var cubit = CommentCubit.get(context).commentPost;
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: (cubit.isEmpty)
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return GetComment(
                                                productId: productId,
                                                OwnerProductId:
                                                    modelDetails.uId!,
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
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No Offers',
                                            style: FontStyleThame.textStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,

                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Send One',
                                            style: FontStyleThame.textStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              fontColor:
                                                  ColorStyle.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return GetComment(
                                                      productId: productId,
                                                      OwnerProductId:
                                                          modelDetails.uId!,
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
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Offers',
                                                  style:
                                                      FontStyleThame.textStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,

                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  height: 45,
                                                  width: 220,
                                                  //  color: Colors.blue,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border:
                                                          Border.all(width: 1),
                                                      color: Colors.blue),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      'Add Your Offer, See Others',
                                                      style: FontStyleThame
                                                          .textStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontColor: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                cubit.first.image!,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cubit.first.name!,
                                                  style:
                                                      FontStyleThame.textStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,

                                                  ),
                                                ),
                                                Text(
                                                  "Owner",
                                                  style:
                                                      FontStyleThame.textStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,

                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Text(
                                              cubit.first.price.toString() +
                                                  r' $',
                                              style: FontStyleThame.textStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                fontColor:
                                                    ColorStyle.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            cubit.first.text!,
                                            style: FontStyleThame.textStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                transform(
                                                    cubit.first.dataTime!),
                                                style: FontStyleThame.textStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  fontColor:
                                                      ColorStyle.primaryColor,
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5,
                                                    right: 5,
                                                    left: 5),
                                                child: Icon(
                                                  Icons.timelapse,
                                                  size: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: (CacheHelper.getData(key: 'uId') != null)
                  ? (modelDetails.uId == CacheHelper.getData(key: 'uId'))
                      ? FloatingActionButton(
                          onPressed: () {
                            modelDetails.fave = !modelDetails.fave!;

                            cubit.updateState(
                              value: modelDetails.fave ?? false,
                              productId: productId,
                            );
                          },
                          backgroundColor: Colors.white,
                          child: Icon(
                            modelDetails.fave == true
                                ? Icons.done
                                : Icons.done_all,
                            color: modelDetails.fave == true
                                ? Colors.red
                                : Colors.green,
                          ),
                        )
                      : null
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
            );
          } else {
            return Scaffold(
              floatingActionButton: (CacheHelper.getData(key: 'uId') != null)
                  ? (modelDetails.uId == CacheHelper.getData(key: 'uId'))
                      ? FloatingActionButton(
                          onPressed: () {
                            modelDetails.fave = !modelDetails.fave!;

                            cubit.updateState(
                              value: modelDetails.fave ?? false,
                              productId: productId,
                            );
                          },
                          backgroundColor: Colors.white,
                          child: Icon(
                            modelDetails.fave == true
                                ? Icons.done
                                : Icons.done_all,
                            color: modelDetails.fave == true
                                ? Colors.red
                                : Colors.green,
                          ),
                        )
                      : null
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              body: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius as desired
                              // Define your custom shape here
                            ),
                            elevation: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // Set the border radius as desired

                              child: Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: [
                                  if (modelDetails.images != null)
                                    CarouselSlider(
                                      items: modelDetails.images!
                                          .asMap()
                                          .entries
                                          .map(
                                        (e) {
                                          final index = e.key;
                                          final imageUrl = e.value;
                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  242, 242, 242, 1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional
                                                  .bottomStart,
                                              children: [
                                                Image(
                                                  image: NetworkImage(imageUrl),
                                                  fit: BoxFit.cover,
                                                  height: 400,
                                                  width: double.infinity,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 50,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: ColorStyle.gray,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(Icons.image),
                                                          Text(
                                                              '${index + 1}/${modelDetails.images!.length}')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      options: CarouselOptions(
                                        height: 400,
                                        viewportFraction: 1.0,
                                        enlargeCenterPage: false,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: false,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            const Duration(seconds: 1),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          cubit.updateValueFavBool();
                                          cubit.updateValueFav(
                                              value: modelDetails,
                                              productId: productId);
                                        },
                                        icon: Icon(
                                          cubit.isFav == true
                                              ? IconlyBold.heart
                                              : IconlyLight.heart,
                                          color: cubit.isFav == true
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Share.share(
                                            "🌟 Exciting news! Introducing ${modelDetails.cat} - your new go-to solution for ${modelDetails.description}.  🚀 Try it now and experience the difference! #Innovation #ProductivityBoost",
                                            subject: 'Check out this offer!',
                                          );
                                        },
                                        icon: Icon(
                                          Icons.share,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius as desired
                              // Define your custom shape here
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    modelDetails.cat ?? 'category',
                                    style: FontStyleThame.textStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,

                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.toString(),
                                        style: FontStyleThame.textStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Views',
                                        style: FontStyleThame.textStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.timelapse_outlined,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        transform(modelDetails.time ??
                                            'Tue Mar 29 2024 16:25:43 GMT+0530 (IST)'),
                                        style: FontStyleThame.textStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        IconlyLight.location,
                                        size: 14,
                                        color: ColorStyle.primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          modelDetails.location ?? 'location',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyleThame.textStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ',',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyleThame.textStyle(
                                          fontWeight: FontWeight.w600,
                                          fontColor: ColorStyle.gray,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Icon(
                                        Icons.bar_chart,
                                        size: 14,
                                        color: ColorStyle.primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          modelDetails.reasonOfOffer ?? 'reason',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyleThame.textStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ',',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyleThame.textStyle(
                                          fontWeight: FontWeight.w600,
                                          fontColor: ColorStyle.gray,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Icon(
                                        Icons.attach_money,
                                        size: 14,
                                        color: ColorStyle.primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          modelDetails.price ?? 'price',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyleThame.textStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    S.of(context).description,
                                    style: FontStyleThame.textStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,

                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      final textSpan = TextSpan(
                                        text: modelDetails.description ??
                                            'description',
                                        style: FontStyleThame.textStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      );
                                      final textPainter = TextPainter(
                                        text: textSpan,
                                        textDirection: TextDirection.ltr,
                                        maxLines: 3,
                                      );
                                      textPainter.layout(
                                          maxWidth: constraints.maxWidth);
                                      final isTextOverflowing =
                                          textPainter.didExceedMaxLines;

                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            textSpan,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            textAlign: TextAlign.left,
                                          ),
                                          if (isTextOverflowing) // Add message if text exceeds three lines
                                            const Text(
                                              '...',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black38,
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius as desired
                              // Define your custom shape here
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Location',
                                    style: FontStyleThame.textStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,

                                    ),
                                  ),
                                ),
                                if (modelDetails.lan != null && modelDetails.lat != null)
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      height: 300,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadiusDirectional.circular(12),
                                        child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                            zoom: 15.0,
                                            target: LatLng(
                                              modelDetails.lan!,
                                              modelDetails.lat!,
                                            ),
                                          ),
                                          buildingsEnabled: true,
                                          compassEnabled: true,
                                          myLocationEnabled: true,
                                          indoorViewEnabled: true,
                                          mapToolbarEnabled: true,
                                          myLocationButtonEnabled: true,
                                          zoomGesturesEnabled: true,
                                          onMapCreated: (controller) {},
                                        ),
                                      ),
                                    ),
                                  ),
                                if (modelDetails.lan == null && modelDetails.lat == null)
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      height: 300,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadiusDirectional.circular(12),
                                        child: GoogleMap(
                                          mapType: MapType.hybrid,
                                          initialCameraPosition: const CameraPosition(
                                            zoom: 10,
                                            target: LatLng(
                                              30,
                                              20,
                                            ),
                                          ),
                                          buildingsEnabled: true,
                                          compassEnabled: true,
                                          myLocationEnabled: true,
                                          indoorViewEnabled: true,
                                          mapToolbarEnabled: true,
                                          myLocationButtonEnabled: true,
                                          onMapCreated: (controller) {},
                                        ),
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
                  SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the border radius as desired
                            // Define your custom shape here
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(cubit
                                              .userModel ==
                                          null
                                      ? "https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740&t=st=1710334520~exp=1710335120~hmac=f053daa6a74128973e2f7512cd8b6eaae51a0716ece0866a6b355e1c900a61e6"
                                      : cubit.userModel!.image!),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.userModel == null
                                          ? "user"
                                          : cubit.userModel!.name!,
                                      style: FontStyleThame.textStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,

                                      ),
                                    ),
                                    Text(
                                      "Owner",
                                      style: FontStyleThame.textStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,

                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    cubit.makePhoneCall(
                                        phone: cubit.userModel!.phone!);
                                  },
                                  color: ColorStyle.primaryColor,
                                  icon: const Icon(
                                    IconlyLight.call,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.openWhatsApp(
                                        phone: cubit.userModel!.phone!);
                                  },
                                  color: const Color.fromRGBO(37, 211, 102, 1),
                                  icon: const Icon(
                                    IconlyLight.chat,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: BlocConsumer<CommentCubit, CommentState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              var cubit = CommentCubit.get(context).commentPost;
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Set the border radius as desired
                                  // Define your custom shape here
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'All Offers',
                                          style: FontStyleThame.textStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            fontColor: ColorStyle.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GetComment(
                                          productId: productId,
                                          OwnerProductId: modelDetails.uId!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
