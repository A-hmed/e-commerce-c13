import 'package:ecommerce_app/core/network/errors.dart';

class ApiResult<T> {
  bool get hasError => this is ErrorApiResult;

  bool get isSuccess => this is SuccessApiResult;

  String get errorMessage => (this as ErrorApiResult).appError.errorMessage;

  AppErrors get error => (this as ErrorApiResult).appError;

  T getData() => (this as SuccessApiResult<T>).data;
}

class SuccessApiResult<T> extends ApiResult<T> {
  T data;

  SuccessApiResult(this.data);
}

class ErrorApiResult<T> extends ApiResult<T> {
  AppErrors appError;

  ErrorApiResult(this.appError);
}
