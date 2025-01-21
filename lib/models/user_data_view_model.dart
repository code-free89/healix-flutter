class UserViewModel {
  String? id;
  String? name;
  String? gender;
  String? height;
  String? weight;
  String? email;
  String? phone;
  String? dateOfBirth;
  Address? address;
  List<String>? allergies;
  List<String>? cuisinePreference;
  List<String>? healthHistory;
  List<String>? dietPreference;
  List<String>? wellnessGoals = [];

  UserViewModel(
      {this.id,
      this.name,
      this.gender,
      this.height,
      this.dateOfBirth,
      this.weight,
      this.email,
      this.phone,
      this.address,
      this.allergies,
      this.wellnessGoals,
      this.cuisinePreference,
      this.healthHistory,
      this.dietPreference});

  UserViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    height = json['height'];
    weight = json['weight'];
    email = json['email'];
    phone = json['phone'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    allergies = json['allergies'].cast<String>();
    cuisinePreference = json['cuisinePreference'].cast<String>();
    healthHistory = json['healthHistory'].cast<String>();
    dietPreference = json['dietPreference'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dateOfBirth'] = this.dateOfBirth;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['allergies'] = this.allergies;
    data['cuisinePreference'] = this.cuisinePreference;
    data['healthHistory'] = this.healthHistory;
    data['dietPreference'] = this.dietPreference;
    data['wellnessGoals'] = this.wellnessGoals;
    return data;
  }
}

class Address {
  String? city;
  String? country;
  String? state;
  String? street;
  String? unit;
  String? zipcode;

  Address(
      {this.city,
      this.country,
      this.state,
      this.street,
      this.unit,
      this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    state = json['state'];
    street = json['street'];
    unit = json['unit'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['street'] = this.street;
    data['unit'] = this.unit;
    data['zipcode'] = this.zipcode;
    return data;
  }
}
