class BaseResponse {
  String? message;

  BaseResponse();

  BaseResponse.fromJson(dynamic json) {
    message = json["message"];
  }
}
