import 'package:sell_4_u/Features/Home-feature/models/product_model.dart';

abstract class SettingState {}

class SettingInitial extends SettingState {}

class GetUserdataSuccess extends SettingState {}

class ErrorGetUserdata extends SettingState {}

class LoadingGetUserdata extends SettingState {}

///todo UpdateUserdata
class UpdateLoadingUserDataState extends SettingState {}

class UpdateSuccessUserDataState extends SettingState {}

class UpdateErrorUserDataState extends SettingState {}

class SuccessGetFavoriteData extends SettingState {}

class ErrorGetFavoriteData extends SettingState {}

class LoadingGetFavoriteData extends SettingState {}

class SuccessGetListData extends SettingState {}

class ErrorGetListData extends SettingState {}

class LoadingGetListData extends SettingState {}

class UpdateSuccessListData extends SettingState {}

class UpdateErrorListData extends SettingState {}

class LoadingUpdateListData extends SettingState {}

class SuccessGetCategoriesData extends SettingState {
  final List<ProductModel> categoriesModel;
  final List<String?> searchIdes;

  SuccessGetCategoriesData(this.categoriesModel, this.searchIdes);
}

class ErrorGetCategoriesData extends SettingState {}

class LoadingGetCategoriesData extends SettingState {}

class ImageUploadLoading extends SettingState {}

class ImageUploadSuccess extends SettingState {}

class ImageUploadFailed extends SettingState {}
