import 'package:ecommerce_app/core/network/errors.dart';

class ApiState<T> {
  bool get hasError => this is ErrorApiState;

  bool get isSuccess => this is SuccessApiState;

  bool get isLoading => this is LoadingApiState;

  String get errorMessage => (this as ErrorApiState).appError.errorMessage;

  AppErrors get error => (this as ErrorApiState).appError;

  T getData() => (this as SuccessApiState<T>).data;
}

class SuccessApiState<T> extends ApiState<T> {
  T data;

  SuccessApiState(this.data);
}

class ErrorApiState<T> extends ApiState<T> {
  AppErrors appError;

  ErrorApiState(this.appError);
}

class LoadingApiState extends ApiState {}

class IdleApiState extends ApiState {}
