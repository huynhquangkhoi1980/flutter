import 'package:mevn_app/news/models/post.dart';

class HomeRes {
  List<Post>? posts;

  HomeRes({this.posts});

  HomeRes.fromJson(List<dynamic> json) {
    posts = <Post>[];

    // ignore: avoid_function_literals_in_foreach_calls
    json.forEach((v) {
      posts!.add(Post.fromJson(v as Map<String, dynamic>));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
