abstract class RegisterState {}


class LoadingRegisterState extends RegisterState {}
class RegisterInitialState extends RegisterState {}
class SuccessRegisterState extends RegisterState {
  final String uId;
  SuccessRegisterState(
      this.uId
      );
}
class ErrorRegisterState extends RegisterState {}
class SuccessVerisyState extends RegisterState {}

class ErrorVerifyState extends RegisterState {
  final String? errorMessage;

  ErrorVerifyState({this.errorMessage});
}
class SuccessCreateUserState extends RegisterState {
  final String uId;
  SuccessCreateUserState(this.uId);

}
class ErrorCreateUserState extends RegisterState {}

class ChangePasswordVisibilityState extends RegisterState {}
