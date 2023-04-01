class Book {
  String? title;
  String? link;
  String? purpose;
  String? kind;
  String? approved;
  String? comment;
  String? commentCorporate;

  // ignore: require_trailing_commas
  Book({
    required this.title,
    required this.link,
    required this.purpose,
    required this.kind,
    required this.approved,
    required this.comment,
    required this.commentCorporate,
  });

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    link = json['link'] as String;
    purpose = json['purpose'] as String;
    kind = json['kind'] as String;
    approved = json['approved'] as String;
    comment = json['comment'] as String;
    commentCorporate = json['commentCorporate'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['purpose'] = purpose;
    data['kind'] = kind;
    data['approved'] = approved;
    data['comment'] = comment;
    data['commentCorporate'] = commentCorporate;
    return data;
  }
}
