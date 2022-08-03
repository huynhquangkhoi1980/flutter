class Book {
  String? title;
  String? link;
  String? purpose;
  String? kind;

  Book({
    required this.title,
    required this.link,
    required this.purpose,
    required this.kind,
  });

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    link = json['link'] as String;
    purpose = json['purpose'] as String;
    kind = json['kind'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['purpose'] = purpose;
    data['kind'] = kind;
    return data;
  }
}
