import 'package:ecommerce_app/core/network/errors.dart';

///The result from the api

class ApiResult<T> {
  bool get hasError => this is ErrorApiResult;

  bool get hasData => this is SuccessApiResult;

  String get errorMessage => (this as ErrorApiResult).appErrors.errorMessage;

  AppErrors get error => (this as ErrorApiResult).appErrors;

  T getData() => (this as SuccessApiResult<T>).data;
}

class SuccessApiResult<E> extends ApiResult<E> {
  E data;

  SuccessApiResult(this.data);
}

class ErrorApiResult<E> extends ApiResult<E> {
  AppErrors appErrors;

  ErrorApiResult(this.appErrors);
}
