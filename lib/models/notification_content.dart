class NotificationContent {
  String? id;
  String? query;
  Choices? choices;

  NotificationContent({this.id, this.query, this.choices});

  NotificationContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    query = json['query'];
    choices =
        json['choices'] != null ? new Choices.fromJson(json['choices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['query'] = this.query;
    if (this.choices != null) {
      data['choices'] = this.choices!.toJson();
    }
    return data;
  }
}

class Choices {
  String? a;
  String? b;
  String? c;
  String? d;

  Choices({this.a, this.b, this.c, this.d});

  Choices.fromJson(Map<String, dynamic> json) {
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['A'] = this.a;
    data['B'] = this.b;
    data['C'] = this.c;
    data['D'] = this.d;
    return data;
  }
}
