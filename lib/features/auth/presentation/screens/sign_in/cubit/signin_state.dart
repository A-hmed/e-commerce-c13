import 'package:ecommerce_app/core/utils/api_state.dart';

class SignInState {
  late ApiState loginApiState = IdleApiState();

  SignInState({required this.loginApiState});

  SignInState.initial() {
    loginApiState = IdleApiState();
  }
}
