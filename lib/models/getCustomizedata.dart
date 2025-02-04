import 'dart:convert';

import 'package:isar/isar.dart';

part 'getCustomizedata.g.dart';

@collection
class CustomizedResponse {
  Id isarId = Isar.autoIncrement;
  String id;
  String searchText;
  String gptResponse;

  @ignore
  final Map<String, dynamic>? healthData; // Adjust type as needed
  String? healthDataMapString;

  String intent;

  @ignore
  dynamic menuItem; // Can be String or MenuItem
  String? menuItemString;

  CustomizedResponse({
    required this.id,
    required this.searchText,
    required this.gptResponse,
    this.healthData,
    this.healthDataMapString,
    required this.intent,
    this.menuItem,
    this.menuItemString,
  });

  factory CustomizedResponse.fromJson(Map<String, dynamic> json) {
    // Parse menuItem to handle both String and MenuItem cases
    dynamic parsedMenuItem;
    if (json['menu_item'] is String) {
      parsedMenuItem = json['menu_item'];
    } else if (json['menu_item'] is Map<String, dynamic>) {
      parsedMenuItem = MenuItem.fromJson(json['menu_item']);
    }

    return CustomizedResponse(
      id: json['id'],
      searchText: json['search_text'],
      gptResponse: json['gpt_response'],
      healthData: (json['health_data'] is Map) ? json['health_data'] : null,
      intent: json['intent'],
      menuItem: parsedMenuItem,
    );
  }

  factory CustomizedResponse.fromIsar(CustomizedResponse response) {
    dynamic parsedMenuItem;
    if (response.menuItemString != null) {
      parsedMenuItem = IsarHelper.parseMenuItem(response.menuItemString!);
    }
    return CustomizedResponse(
      id: response.id,
      searchText: response.searchText,
      gptResponse: response.gptResponse,
      healthData: response.healthData,
      intent: response.intent,
      menuItem: parsedMenuItem,
      menuItemString: response.menuItemString,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['search_text'] = searchText;
    data['gpt_response'] = gptResponse;
    data['health_data'] = healthData;
    data['intent'] = intent;

    // Serialize menuItem based on its type
    if (menuItem is String) {
      data['menu_item'] = menuItem;
    } else if (menuItem is MenuItem) {
      data['menu_item'] = (menuItem as MenuItem).toJson();
    }

    return data;
  }
}

class MenuItem {
  String? name;
  String? productId;
  double? price;
  String? image;
  List<Customizations>? customizations;

  MenuItem(
      {this.name, this.productId, this.price, this.image, this.customizations});

  MenuItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productId = json['product_id'];
    price = json['price'];
    image = json['image'];
    if (json['customizations'] != null) {
      customizations = <Customizations>[];
      json['customizations'].forEach((v) {
        customizations!.add(Customizations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['product_id'] = productId;
    data['price'] = price;
    data['image'] = image;
    if (customizations != null) {
      data['customizations'] = customizations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customizations {
  String? optionName;
  String? optionId;

  Customizations({this.optionName, this.optionId});

  Customizations.fromJson(Map<String, dynamic> json) {
    optionName = json['option_name'];
    optionId = json['option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_name'] = optionName;
    data['option_id'] = optionId;
    return data;
  }
}

class IsarHelper {
  static Map<String, dynamic> parseJson(String jsonString) {
    // Parse JSON string to Map
    return Map<String, dynamic>.from(
        IsarHelper.jsonDecode(jsonString) as Map<String, dynamic>);
  }

  static dynamic parseMenuItem(String menuItemString) {
    // Deserialize menuItemString
    final jsonData = IsarHelper.jsonDecode(menuItemString);
    if (jsonData is String) {
      return jsonData;
    } else if (jsonData is Map<String, dynamic>) {
      return MenuItem.fromJson(jsonData);
    }
    return null;
  }

  static dynamic jsonDecode(String jsonString) {
    // You can replace with your preferred JSON decoding method
    return const JsonDecoder().convert(jsonString);
  }
}
