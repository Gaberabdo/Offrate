import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/Features/chat_feature/cubit/chat-cubit.dart';
import 'package:sell_4_u/Features/chat_feature/screens/chat-details-admin.dart';
import '../../../../core/helper/cache/cache_helper.dart';
import '../../cubit/chat-states.dart';

class AllUserScreen extends StatelessWidget {
  const AllUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getAllUserData(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Admin',
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChatDetailsScreen(
                          model: cubit.admin!,
                        );
                      },
                    ),
                  );
                },
                child: cubit.admin != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: CacheHelper.getData(key: "isDark") == null
                              ? const Color.fromRGBO(242, 242, 242, 1)
                              : CacheHelper.getData(key: "isDark")
                                  ? Colors.white12
                                  : const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    NetworkImage(cubit.admin!.image!),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Custom Service'),
                            ],
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAllItemUser({
    required BuildContext context,
    required UserModel model,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatDetailsScreen(
                  model: model,
                );
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(model.image!),
              ),
              const Spacer(),
              Text(model.name!),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
