class FinalQuoteDataModel {
  String? message;
  String? trackingLink;

  FinalQuoteDataModel({this.message, this.trackingLink});

  FinalQuoteDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    trackingLink = json['tracking_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['tracking_link'] = this.trackingLink;
    return data;
  }
}
