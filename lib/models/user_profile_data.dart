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

  UserProfileData({
    this.height,
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
    this.name,
  }) {
    healthHistory ??= [];
    allergies ??= [];
    cuisinePreference ??= [];
    dietPreference ??= [];
  }

  UserProfileData.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    healthHistory = json['healthHistory']?.cast<String>() ?? [];
    id = json['id'];
    phone = json['phone'];
    allergies = json['allergies']?.cast<String>() ?? [];
    cuisinePreference = json['cuisinePreference']?.cast<String>() ?? [];
    address = _parseAddress(json['address']);
    email = json['email'];
    dietPreference = json['dietPreference']?.cast<String>() ?? [];
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
    data['address'] = _serializeAddress(address);
    data['email'] = email;
    data['dietPreference'] = dietPreference;
    data['gender'] = gender;
    data['name'] = name;
    return data;
  }

  dynamic _parseAddress(dynamic addressJson) {
    if (addressJson is String) {
      return addressJson;
    } else if (addressJson is Map<String, dynamic>) {
      return Address.fromJson(addressJson);
    }
    return null;
  }

  dynamic _serializeAddress(dynamic address) {
    if (address is Address) {
      return address.toJson();
    }
    return address;
  }
}

class Address {
  String? city;
  String? state;
  String? zipcode;
  String? street;
  String? unit;
  String? country;

  Address({
    this.city,
    this.state,
    this.zipcode,
    this.street,
    this.unit,
    this.country,
  });

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    street = json['street'];
    unit = json['unit'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'street': street,
      'unit': unit,
      'country': country,
    };
  }

  /// Converts the address to a formatted string
  String toFormattedString() {
    List<String> parts = [
      if (street != null && street!.isNotEmpty) street!,
      if (unit != null && unit!.isNotEmpty) unit!,
      if (city != null && city!.isNotEmpty) city!,
      if (state != null && state!.isNotEmpty) state!,
      if (zipcode != null && zipcode!.isNotEmpty) zipcode!,
      if (country != null && country!.isNotEmpty) country!,
    ];
    return parts.join(', ');
  }

  @override
  String toString() {
    return 'Address(city: $city, state: $state, zipcode: $zipcode, street: $street, unit: $unit, country: $country)';
  }
}
