import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/Features/chat_feature/cubit/chat-cubit.dart';
import 'package:sell_4_u/Features/chat_feature/cubit/chat-states.dart';
import 'package:sell_4_u/Features/chat_feature/models/chat_model.dart';
import '../../../core/constant.dart';
import 'package:intl/intl.dart';

import '../../../core/helper/cache/cache_helper.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key, required this.model});

  UserModel model;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()
        ..getAllUserData()
        ..getMessage(receiveId: model!.uId!),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.name!,
                    style: TextStyle(
                      //  fontColor:Colors.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconlyLight.call,
                    // color: ColorStyle().primaryColor,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (cubit.uId == cubit.messages[index].senderId) {
                    return myMessages(cubit.messages[index], context);
                  } else {
                    return senderMessage(cubit.messages[index], context);
                  }
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: cubit.messages.length,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: CacheHelper.getData(key: "isDark") == null
                                ? const Color.fromRGBO(242, 242, 242, 1)
                                : CacheHelper.getData(key: "isDark")
                                    ? Colors.white12
                                    : const Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.blue,
                            controller: textController,
                            onFieldSubmitted: (value) {
                              String formattedDate =
                                  DateFormat('E MMM d y HH:mm:ss \'GMT\'Z (z)')
                                      .format(DateTime.now());
                              cubit.sendMessage(
                                text: textController.text,
                                dateTime: formattedDate,
                                receiverId: model.uId!,
                              );
                            },
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.dark,
                            decoration: InputDecoration(
                              hintText: 'Write Your Message',
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          String formattedDate =
                              DateFormat('E MMM d y HH:mm:ss \'GMT\'Z (z)')
                                  .format(DateTime.now());
                          cubit.sendMessage(
                            text: textController.text,
                            dateTime: formattedDate,
                            receiverId: model.uId!,
                          );

                          cubit.removePostImage();
                        },
                        child: CircleAvatar(
                          radius: 28,
                          child: const Icon(
                            IconlyLight.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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

Widget myMessages(MessageModel model, context) {
  return Align(
    alignment: AlignmentDirectional.bottomStart,
    child: Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(229, 244, 255, 1),
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.done_all,
                  size: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                // Text(
                //   transform(model.time!),
                //   style: const TextStyle(fontSize: 12),
                // ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    '${model.message}',
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            if (model.image != '')
              Image.network(
                model.image.toString(),
                height: 150,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget senderMessage(MessageModel model, context) {
  return Align(
    alignment: AlignmentDirectional.bottomEnd,
    child: Container(
      decoration: const BoxDecoration(
        color: const Color.fromRGBO(242, 242, 242, 1),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${model.message}',
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  transform(model.time!),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Icon(
                  Icons.done_all,
                  size: 12,
                ),
              ],
            ),
            if (model.image != '')
              Image.network(
                model.image.toString(),
                height: 150,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    ),
  );
}
