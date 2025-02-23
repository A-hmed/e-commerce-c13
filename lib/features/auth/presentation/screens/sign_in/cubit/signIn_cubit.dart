import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_in/cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final LoginUseCase _loginUseCase;

  SignInCubit(this._loginUseCase) : super(SignInState.initial());

  void login(String email, String password) async {
    print(
        "Emitting new state: ${SignInState(loginApiState: LoadingApiState()).loginApiState}");
    emit(SignInState(loginApiState: LoadingApiState()));

    var apiResult = await _loginUseCase
        .execute(LoginRequest(email: email, password: password));

    if (apiResult.hasData) {
      emit(SignInState(loginApiState: SuccessApiState(null)));
    } else {
      emit(SignInState(loginApiState: ErrorApiState(apiResult.error)));
    }
  }
}
