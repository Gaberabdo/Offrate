import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_state.dart';

import 'package:sell_4_u/core/helper/cache/cache_helper.dart';


import '../../Auth-feature/manger/model/user_model.dart';
import '../../Home-feature/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  UserModel model = UserModel();

  Future<void> getUser() async {
    print('uuuuuuuuuuuuuuuuuiiiiiiiiiiiiid${CacheHelper.getData(key: 'uId')}');
    fireStore
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .snapshots()
        .listen((value) {
      model = UserModel.fromJson(value.data()!);
      emit(GetUserdataSuccess());
    }).onError((handleError) {
      emit(ErrorGetUserdata());
    });
    emit(LoadingGetUserdata());
  }

  List<ProductModel> favoriteModel = [];
  List<String> faveId = [];

  Future<void> getFavorite() async {
    emit(LoadingGetFavoriteData());
    fireStore
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .collection('fave')
        .snapshots()
        .listen((value) {
      favoriteModel.clear();
      faveId.clear();
      value.docs.forEach((element) {
        favoriteModel.add(ProductModel.fromJson(element.data()));
        faveId.add(element.id);
      });
      emit(SuccessGetFavoriteData());
    }).onError((handleError) {
      emit(ErrorGetFavoriteData());
    });
  }

  List<ProductModel> listModel = [];
  List<String> mostPopularIdes = [];

  Future<void> getList() async {
    emit(LoadingGetListData());
    fireStore
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .collection('products')
        .snapshots()
        .listen((value) {
      listModel.clear();
      mostPopularIdes.clear();
      value.docs.forEach((element) {
        mostPopularIdes.add(element.id);
        listModel.add(ProductModel.fromJson(element.data()));
      });
      emit(SuccessGetListData());
    }).onError((handleError) {
      emit(ErrorGetListData());
    });
  }

  List<ProductModel> searchList = [];
  List<String> searchIdes = [];

  Future<void> getListSearch() async {
    emit(LoadingGetListData());
    fireStore.collection('products').snapshots().listen((value) {
      searchList.clear();
      searchIdes.clear();
      value.docs.forEach((element) {
        searchIdes.add(element.id);
        searchList.add(ProductModel.fromJson(element.data()));
      });
      emit(SuccessGetListData());
    }).onError((handleError) {
      emit(ErrorGetListData());
    });
  }

  void searchInList(String query) {
    emit(LoadingGetCategoriesData());
    if (query.isEmpty || searchList.where((student) => student.cat!.toLowerCase().contains(query.toLowerCase())).isEmpty) {
      emit(ErrorGetCategoriesData());
    } else {
     final filteredList = searchList.where((student) => student.cat!.toLowerCase().contains(query.toLowerCase()));
      emit(SuccessGetCategoriesData(filteredList.toList(), searchIdes));
    }
  }

  File? profileImage;

  bool isUpload = false;
  List<String> categoriesIdes = [];

  Future<void> pickImagesAdd() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImages != null) {
      profileImage = File(pickedImages.path);
      emit(ImageUploadSuccess());
    } else {
      emit(ImageUploadFailed());
    }
  }

  Future<void> uploadImage({
    required String name,
  }) async {
    isUpload = true;
    emit(ImageUploadLoading());
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('catImage/${Uri.file(profileImage!.path).pathSegments.last}');
    await ref.putFile(profileImage!).then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          image: value,
        );
        emit(ImageUploadSuccess());
      });
    });
  }

  Future<void> updateUser({
    required String name,
    required String image,
  }) async {
    isUpload = true;

    emit(UpdateLoadingUserDataState());
    await fireStore
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .update({
      'name': name,
      'image': image,
    }).then((value) {
      emit(UpdateSuccessUserDataState());
      isUpload = false;
    }).catchError((error) {
      emit(UpdateErrorUserDataState());
    });
  }
}
