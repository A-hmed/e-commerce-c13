class AppErrors {
  String errorMessage;

  AppErrors(this.errorMessage);
}

class NetworkError extends AppErrors {
  NetworkError()
      : super("Please check your internet connection and try again later");
}

const String defaultMessage = "Something went wrong please try again later";

class ServerError extends AppErrors {
  ServerError([String? message = defaultMessage])
      : super(message ?? defaultMessage);
}

class IgnoredError extends AppErrors {
  IgnoredError(super.errorMessage);
}

class UndefinedErrors extends AppErrors {
  UndefinedErrors(super.errorMessage);
}
