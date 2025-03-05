import 'package:ecommerce_app/core/network/errors.dart';

class ApiState<T> {
  bool get hasError => this is ErrorApiState;

  bool get isSuccess => this is SuccessApiState;

  bool get isLoading => this is LoadingApiState;

  String get errorMessage => (this as ErrorApiState).appErrors.errorMessage;

  AppErrors get error => (this as ErrorApiState).appErrors;

  T get data => (this as SuccessApiState<T>).data;
}

class SuccessApiState<E> extends ApiState<E> {
  E data;

  SuccessApiState(this.data);
}

class ErrorApiState<E> extends ApiState<E> {
  AppErrors appErrors;

  ErrorApiState(this.appErrors);
}

class LoadingApiState<E> extends ApiState<E> {}

///Api is not called yet
class IdleApiState<E> extends ApiState<E> {}
