class CustomizedResponse {
  final String id;
  final String searchText;
  final String gptResponse;
  final Map<String, dynamic> healthData; // Adjust type as needed

  CustomizedResponse({
    required this.id,
    required this.searchText,
    required this.gptResponse,
    required this.healthData,
  });

  factory CustomizedResponse.fromJson(Map<String, dynamic> json) {
    return CustomizedResponse(
      id: json['id'],
      searchText: json['search_text'],
      gptResponse: json['gpt_response'],
      healthData: json['health_data'],
    );
  }
}
