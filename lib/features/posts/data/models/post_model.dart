import '../../domaine/entities/post_entitie.dart';

class PostModel extends PostEntitie {
  const PostModel({super.id, required super.title, required super.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json["id"], title: json["title"], body: json["body"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "body": body};
  }
}
