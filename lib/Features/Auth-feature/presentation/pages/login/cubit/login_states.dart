abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {

  final String uId;
  SuccessLoginState(
      this.uId
      );

}
class PhoneNotRegisterstate extends LoginState {}
class PhoneRegisterState extends LoginState {}



class SuccessGoogleLoginState extends LoginState {
 final String uId;
  SuccessGoogleLoginState(
     this. uId
      );


}
class SuccessFaceLoginState extends LoginState {
  final String uId;
  SuccessFaceLoginState(
      this.uId
      );


}
class ErrorLoginState extends LoginState {}
class UsernotRegister extends LoginState {}



class ChangeVisiabilty extends LoginState {}


