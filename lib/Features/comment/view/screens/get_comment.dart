import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/comment/controller/Commet_cubit/comment_cubit.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/cache/cache_helper.dart';
import 'package:sell_4_u/core/responsive_screen.dart';

import '../../../Auth-feature/presentation/pages/login/login_screen.dart';
import '../../model/comment_model.dart';

class GetComment extends StatelessWidget {
  GetComment({
    super.key,
    required this.productId,
    required this.OwnerProductId,
  });

  final String productId;
  final String OwnerProductId;
  final textController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit()
        ..getComment(
          productId: productId,
        )
        ..getUser(),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CommentCubit.get(context);
          var userModel = cubit.model;
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
                "Offers",
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildCommentItem(
                    context: context,
                    commentModel: cubit.commentPost[index],
                  ),
                );
              },
              itemCount: cubit.commentPost.length,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                IconlyLight.plus,
                color: ColorStyle.primaryColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Text(
                            isArabic() ? 'أضف عرضك' : "Add your offer",
                            style: FontStyleThame.textStyle(
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                            ),
                          )
                        ],
                      ),
                      content: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: ColorStyle.gray,
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: textController,
                                  style: FontStyleThame.textStyle(
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Write Comment...",
                                    counterStyle: FontStyleThame.textStyle(
                                      fontSize: 13,
                                    ),
                                    hintStyle: FontStyleThame.textStyle(
                                      fontSize: 13,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusColor: Colors.grey,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: ColorStyle.gray,
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  style: FontStyleThame.textStyle(
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Write Price...",
                                    counterStyle: FontStyleThame.textStyle(
                                      fontSize: 13,
                                    ),
                                    hintStyle: FontStyleThame.textStyle(
                                      fontSize: 13,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusColor: Colors.grey,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 44,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (textController.text.isNotEmpty &&
                                      priceController.text.isNotEmpty) {
                                    if (CacheHelper.getData(key: 'uId') !=
                                        null) {
                                      if (CacheHelper.getData(
                                              key: "isBlocked") ==
                                          false) {
                                        cubit.createComment(
                                          productId: productId,
                                          comment: textController.text,
                                          name: userModel.name!,
                                          phone: userModel.phone!,
                                          image: userModel.image!,
                                          price: double.parse(
                                              priceController.text),
                                        );
                                        textController.clear();
                                        priceController.clear();
                                        Navigator.pop(context);
                                      } else {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.rightSlide,
                                          title: 'Warning',
                                          desc: 'Your account is blocked',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {},
                                        ).show();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => LoginScreen()));
                                      }
                                    } else {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return LoginScreen();
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
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: ColorStyle.primaryColor,
                                  elevation: 0,
                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  )),
                                ),
                                child: Text(
                                  isArabic() ? 'نعم' : 'Confirm',
                                  style: FontStyleThame.textStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildCommentItem({
    required BuildContext context,
    required CommentModel commentModel,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(commentModel.image!),
          backgroundColor: Colors.white,
          radius: 25,
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ResponsiveScreen.setColorTheme(
                    ColorStyle.gray,
                    Colors.black12,
                    context,
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(0),
                    topEnd: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                    bottomStart: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            commentModel.name!,
                            style: FontStyleThame.textStyle(
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          if (CacheHelper.getData(key: 'uId') != null)
                            if (CacheHelper.getData(key: 'uId') ==
                                OwnerProductId)
                              InkWell(
                                onTap: () {
                                  CommentCubit.get(context).makePhoneCall(
                                      phone: commentModel.phone!);
                                },
                                child: Icon(
                                  size: 18,
                                  IconlyLight.call,
                                ),
                              )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .8,
                        child: Text(
                          commentModel.text!,
                          style: FontStyleThame.textStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  DefaultTextStyle(
                    style: FontStyleThame.textStyle(
                        fontColor: ColorStyle.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        commentModel.price.toString() + r"$",
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      transform(commentModel.dataTime!),
                      style: FontStyleThame.textStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
