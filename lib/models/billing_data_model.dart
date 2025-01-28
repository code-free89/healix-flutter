class BillingDataModel {
  String? id;
  String? userEmail;
  int? cardNumber;
  int? expirationYear;
  int? expirationMonth;
  String? cvc;

  BillingDataModel(
      {this.id,
        this.userEmail,
        this.cardNumber,
        this.expirationYear,
        this.expirationMonth,
        this.cvc});

  BillingDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userEmail = json['user_email'];
    cardNumber = json['card_number'];
    expirationYear = json['expiration_year'];
    expirationMonth = json['expiration_month'];
    cvc = json['cvc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_email'] = this.userEmail;
    data['card_number'] = this.cardNumber;
    data['expiration_year'] = this.expirationYear;
    data['expiration_month'] = this.expirationMonth;
    data['cvc'] = this.cvc;
    return data;
  }
}
