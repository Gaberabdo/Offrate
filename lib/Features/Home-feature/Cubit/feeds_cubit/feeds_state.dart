
abstract class FeedsState {}

class FeedsInitial extends FeedsState {}

class GetCategoryLoading extends FeedsState {}
class GetCategorySuccess extends FeedsState {}
class GetCategoryDetailsSuccess extends FeedsState {}
class GetCategoryError extends FeedsState {}

class GetMostPopularLoading extends FeedsState {}
class GetMostPopularSuccess extends FeedsState {}
class GetMostPopularError extends FeedsState {}


class GetUserLoading extends FeedsState {}
class GetUserSuccess extends FeedsState {}
class GetUserError extends FeedsState {}



class ImageUploadSuccess extends FeedsState {}
class ImageUploadFailed extends FeedsState {}
class ImageRemovedFailed extends FeedsState {}
class RequestLocationPermission extends FeedsState {}

class ImageUploadToFireLoading extends FeedsState {}
class ImageUploadToFireSuccess extends FeedsState {}

class VideoUploadSuccess extends FeedsState {}
class VideoUploadFailed extends FeedsState {}
class VideoRemovedFailed extends FeedsState {}

class VideoUploadToFireLoading extends FeedsState {}
class VideoUploadToFireSuccess extends FeedsState {}


class RequestPostToFireLoading extends FeedsState {}
class RequestPostToFireSuccess extends FeedsState {}
class RequestPostToFireError extends FeedsState {}


class GetLocationLoading extends FeedsState {}
class GetLocationError extends FeedsState {}
class GetLocationSuccess extends FeedsState {}




class ChoosePlans extends FeedsState {}