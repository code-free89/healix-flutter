class CustomizedRequest {
  final String id;
  final String searchText;

  CustomizedRequest({required this.id, required this.searchText});

  Map<String, dynamic> toJson() => {
    'id': id,
    'search_text': searchText,
  };
}