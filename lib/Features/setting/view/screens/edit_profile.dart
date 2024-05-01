import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_cubit.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_state.dart';

import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/component/component.dart';

import '../../../../generated/l10n.dart';
import '../../../Auth-feature/manger/model/user_model.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key, required this.model}) : super(key: key);

  final UserModel model;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is UpdateSuccessUserDataState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = SettingCubit.get(context);
          nameController.text = model.name!;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
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
                S.of(context).edit_profile,
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: cubit.profileImage == null
                              ? NetworkImage(
                                  '${model.image}',
                                ) as ImageProvider
                              : FileImage(cubit.profileImage!),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              iconSize: 15,
                              onPressed: () {
                                cubit.pickImagesAdd();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 44,
                      child: TextFormWidget(
                        maxLines: 2,
                        emailController: nameController,
                        prefixIcon: const Icon(
                          Icons.person,
                          size: 15,
                        ),
                        hintText: 'Please write your name',
                        validator: '',
                        obscureText: false,
                        icon: false,
                        enabled: true,
                      ),
                    ),
                  ),
                  Spacer(),
                  (cubit.isUpload) ? const CircularProgressIndicator() :  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorStyle.primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: MaterialButton(
                      onPressed: () async {
                        if (cubit.profileImage == null) {
                          cubit.updateUser(
                            name: nameController.text,
                            image: model.image!,
                          );
                        } else {
                          cubit.uploadImage(name: nameController.text);
                        }
                      },
                      child: Text(
                        S.of(context).editProfile,
                        style: FontStyleThame.textStyle(
                          fontSize: 16,
                          fontColor: Colors.white,
                        ),
                      ),
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
