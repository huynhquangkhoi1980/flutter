class Post {
  late int id;
  String? postAuthor;
  String? postDate;
  String? postDateGmt;
  String? postContent;
  String? postTitle;
  String? postExcerpt;
  String? postStatus;
  String? commentStatus;
  String? pingStatus;
  String? postPassword;
  String? postName;
  String? toPing;
  String? pinged;
  String? postModified;
  String? postModifiedGmt;
  String? postContentFiltered;
  int? postParent;
  String? guid;
  int? menuOrder;
  String? postType;
  String? postMimeType;
  String? commentCount;
  String? filter;

  Post({
    required this.id,
    this.postAuthor,
    this.postDate,
    this.postDateGmt,
    this.postContent,
    this.postTitle,
    this.postExcerpt,
    this.postStatus,
    this.commentStatus,
    this.pingStatus,
    this.postPassword,
    this.postName,
    this.toPing,
    this.pinged,
    this.postModified,
    this.postModifiedGmt,
    this.postContentFiltered,
    this.postParent,
    this.guid,
    this.menuOrder,
    this.postType,
    this.postMimeType,
    this.commentCount,
    this.filter,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['ID'] as int;
    postAuthor = json['post_author'] as String?;
    postDate = json['post_date'] as String?;
    postDateGmt = json['post_date_gmt'] as String?;
    postContent = json['post_content'] as String?;
    postTitle = json['post_title'] as String?;
    postExcerpt = json['post_excerpt'] as String?;
    postStatus = json['post_status'] as String?;
    commentStatus = json['comment_status'] as String?;
    pingStatus = json['ping_status'] as String?;
    postPassword = json['post_password'] as String?;
    postName = json['post_name'] as String?;
    toPing = json['to_ping'] as String?;
    pinged = json['pinged'] as String?;
    postModified = json['post_modified'] as String?;
    postModifiedGmt = json['post_modified_gmt'] as String?;
    postContentFiltered = json['post_content_filtered'] as String?;
    postParent = json['post_parent'] as int?;
    guid = json['guid'] as String?;
    menuOrder = json['menu_order'] as int?;
    postType = json['post_type'] as String?;
    postMimeType = json['post_mime_type'] as String?;
    commentCount = json['comment_count'] as String?;
    filter = json['filter'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ID'] = id;
    data['post_author'] = postAuthor;
    data['post_date'] = postDate;
    data['post_date_gmt'] = postDateGmt;
    data['post_content'] = postContent;
    data['post_title'] = postTitle;
    data['post_excerpt'] = postExcerpt;
    data['post_status'] = postStatus;
    data['comment_status'] = commentStatus;
    data['ping_status'] = pingStatus;
    data['post_password'] = postPassword;
    data['post_name'] = postName;
    data['to_ping'] = toPing;
    data['pinged'] = pinged;
    data['post_modified'] = postModified;
    data['post_modified_gmt'] = postModifiedGmt;
    data['post_content_filtered'] = postContentFiltered;
    data['post_parent'] = postParent;
    data['guid'] = guid;
    data['menu_order'] = menuOrder;
    data['post_type'] = postType;
    data['post_mime_type'] = postMimeType;
    data['comment_count'] = commentCount;
    data['filter'] = filter;
    return data;
  }
}
