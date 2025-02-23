import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_in/cubit/signin_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInCubit extends Cubit<SignInCubitState> {
  LoginUseCase _loginUseCase;

  SignInCubit(this._loginUseCase) : super(SignInCubitState.initial());

  void login(String email, String password) async {
    //todo: check if email and password are valid
    emit(SignInCubitState(loginState: LoadingApiState()));
    ApiResult result = await _loginUseCase
        .execute(LoginRequest(email: email, password: password));

    if (result.isSuccess) {
      emit(SignInCubitState(loginState: SuccessApiState(null)));
    } else {
      emit(SignInCubitState(loginState: ErrorApiState(result.error)));
    }
  }
}
