import 'package:isar/isar.dart';

part 'getCustomizedata.g.dart';

@collection
class CustomizedResponse {
  Id isarId = Isar.autoIncrement;
  final String id;
  final String searchText;
  final String gptResponse;
  @ignore
  final Map<String, dynamic>? healthData; // Adjust type as needed
  final String intent;
  @ignore
  final dynamic menuItem; // Can be String or MenuItem

  CustomizedResponse({
    required this.id,
    required this.searchText,
    required this.gptResponse,
    this.healthData,
    required this.intent,
    this.menuItem,
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
      healthData: json['health_data'],
      intent: json['intent'],
      menuItem: parsedMenuItem,
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
