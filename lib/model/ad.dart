import 'dart:convert';

ModelAd modelNiatFromJson(String str) => ModelAd.fromJson(json.decode(str));

String modelNiatToJson(ModelAd data) => json.encode(data.toJson());

class ModelAd {
  int id;
  String title;
  String content;
  ModelAd({
    required this.id,
    required this.title,
    required this.content,
  });

  factory ModelAd.fromJson(Map<String, dynamic> json) => ModelAd(
        title: json["title"],
        content: json["content"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "id": id,
      };
}
