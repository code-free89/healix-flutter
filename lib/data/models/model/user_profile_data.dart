import 'package:isar/isar.dart';
part 'user_profile_data.g.dart';

@collection
class UserProfileData {
  Id isarId = Isar.autoIncrement;
  String? height;
  String? weight;
  List<String>? healthHistory;
  String? id;
  String? phone;
  List<String>? allergies;
  List<String>? cuisinePreference;
  @ignore
  dynamic address;
  @Index(unique: true)
  String? email;
  List<String>? dietPreference;
  String? gender;
  String? name;

  UserProfileData(
      {this.height,
      this.weight,
      this.healthHistory,
      this.id,
      this.phone,
      this.allergies,
      this.cuisinePreference,
      this.address,
      this.email,
      this.dietPreference,
      this.gender,
      this.name});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    healthHistory = json['healthHistory']?.cast<String>();
    id = json['id'];
    phone = json['phone'];
    allergies = json['allergies']?.cast<String>();
    cuisinePreference = json['cuisinePreference']?.cast<String>();
    // Handle address as either String or Address
    if (json['address'] != null) {
      if (json['address'] is String) {
        address = json['address'];
      } else if (json['address'] is Map<String, dynamic>) {
        address = Address.fromJson(json['address']);
      }
    }
    email = json['email'];
    dietPreference = json['dietPreference']?.cast<String>();
    gender = json['gender'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['weight'] = weight;
    data['healthHistory'] = healthHistory;
    data['id'] = id;
    data['phone'] = phone;
    data['allergies'] = allergies;
    data['cuisinePreference'] = cuisinePreference;
    // Serialize address appropriately
    if (address != null) {
      if (address is Address) {
        data['address'] = (address as Address).toJson();
      } else if (address is String) {
        data['address'] = address;
      }
    }
    data['email'] = email;
    data['dietPreference'] = dietPreference;
    data['gender'] = gender;
    data['name'] = name;
    return data;
  }
}

class Address {
  String? city;
  String? state;
  String? zipcode;
  String? street;
  String? unit;
  String? country;

  Address(
      {this.city,
      this.state,
      this.zipcode,
      this.street,
      this.unit,
      this.country});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    street = json['street'];
    unit = json['unit'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['state'] = state;
    data['zipcode'] = zipcode;
    data['street'] = street;
    data['unit'] = unit;
    data['country'] = country;
    return data;
  }
}
