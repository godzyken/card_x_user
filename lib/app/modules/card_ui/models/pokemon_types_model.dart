class Types {
  List<String>? data;

  Types({this.data});

  Types.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = data;
    return data;
  }
}
