part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class GetCommentLoadingState extends CommentState {}
class GetCommentSuccessState extends CommentState {}
class GetCommentErrorState extends CommentState {}


class CreateCommentLoadingState extends CommentState {}
class CreateCommentSuccessState extends CommentState {}
class CreateCommentErrorState extends CommentState {}

class GetUserdataSuccess extends CommentState {}
class ErrorGetUserdata extends CommentState {}
class LoadingGetUserdata extends CommentState {}
