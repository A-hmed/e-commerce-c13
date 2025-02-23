class AppErrors {
  static const defaultErrorMessage = "Something went wrong, Please try again";
  static const internetErrorMessage = "Please your internet connection";
  String errorMessage;

  AppErrors(this.errorMessage);
}

class ServerError extends AppErrors {
  ServerError([String? errorMessage = AppErrors.defaultErrorMessage])
      : super(errorMessage ?? AppErrors.defaultErrorMessage);
}

class NetworkError extends AppErrors {
  NetworkError({String? errorMessage = AppErrors.internetErrorMessage})
      : super(errorMessage ?? AppErrors.internetErrorMessage);
}

class LoginRequiredError extends AppErrors {
  LoginRequiredError(super.errorMessage);
}
