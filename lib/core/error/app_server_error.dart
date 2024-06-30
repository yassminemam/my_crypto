class AppServerError {
  String? response;
  String? message;
  bool? hasWarning;
  int? type;
  dynamic rateLimit;
  dynamic data;

  AppServerError({this.response, this.message, this.hasWarning, this.type, this.rateLimit, this.data});

  AppServerError.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    message = json['Message'];
    hasWarning = json['HasWarning'];
    type = json['Type'];
    rateLimit = json['RateLimit'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Response'] = this.response;
    data['Message'] = this.message;
    data['HasWarning'] = this.hasWarning;
    data['Type'] = this.type;
    if (this.rateLimit != null) {
      data['RateLimit'] = this.rateLimit!.toJson();
    }
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}
