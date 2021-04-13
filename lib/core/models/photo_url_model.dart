class PhotoUrlModel {
  String? id;
  String? url;
  PhotoUrlModel({this.id, this.url});

  factory PhotoUrlModel.fromJson(Map<String, dynamic> json) {
    return PhotoUrlModel(
      id: json["id"],
      url: json['url'],
    );
  }
  toJson() {
    return {"id": id, "url": url};
  }
}