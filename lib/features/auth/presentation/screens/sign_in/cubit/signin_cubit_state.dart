import 'package:ecommerce_app/core/utils/api_state.dart';

class SignInCubitState {
  late ApiState loginState;

  SignInCubitState({required this.loginState});

  SignInCubitState.initial() {
    loginState = IdleApiState();
  }
}
