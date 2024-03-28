class RecoverPasswordModel {
  bool? status;
  String? message;
  String? verificationCode;

  RecoverPasswordModel({
    this.status,
    this.message,
    this.verificationCode,
  });

  factory RecoverPasswordModel.fromJson(Map<String, dynamic> json) {
    return RecoverPasswordModel(
      status: json['status'],
      message: json['message'],
      verificationCode: json['verificationCode'],
    );
  }
}
