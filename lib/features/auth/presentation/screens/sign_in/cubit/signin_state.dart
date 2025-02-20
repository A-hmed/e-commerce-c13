import 'package:ecommerce_app/core/utils/api_state.dart';

class SignInState {
  late ApiState loginApiState;

  SignInState({required loginApiState});

  SignInState.initial() {
    loginApiState = IdleApiState();
  }
}
