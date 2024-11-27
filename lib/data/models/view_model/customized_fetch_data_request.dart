


import '../model/getCustomizedata.dart';

class CustomizedFetchDataRequest {
  final String id;
  final MenuItem menuItem;

  CustomizedFetchDataRequest({required this.id, required this.menuItem});

  Map<String, dynamic> toJson() => {
    'user_id': id,
    'menu_item': menuItem.toJson(),
  };
}