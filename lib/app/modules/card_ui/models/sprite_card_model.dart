class Sprite {
  String? front_default;

  Sprite({
    this.front_default,
  });

  Sprite.fromJson(Map<String, dynamic> json) {
    front_default = json['front_default'] as String;
  }

  Map<String, dynamic> toJson() {
    final front_default = <String, dynamic>{};
    front_default['front_default'] = front_default;
    return front_default;
  }
}
