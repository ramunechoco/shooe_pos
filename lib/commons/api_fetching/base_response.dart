class BaseResponse {
  final int code;
  final bool isSuccess;
  final String message;
  final Map<String, dynamic>? data;

  BaseResponse({
    required this.code,
    required this.isSuccess,
    required this.message,
    this.data,
  });

  BaseResponse.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        isSuccess = json["isSuccess"],
        message = json["message"],
        data = json["data"];
}
