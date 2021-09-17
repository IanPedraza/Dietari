import 'dart:convert';

class Url {
  static const URL_TYPE_LINK = "link";
  static const URL_TYPE_IMAGE = "image";

  String url;
  String type;

  Url({
    this.url = "",
    this.type = URL_TYPE_LINK,
  });

  Url copyWith({
    String? url,
    String? type,
  }) {
    return Url(
      url: url ?? this.url,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type,
    };
  }

  factory Url.fromMap(Map<String, dynamic> map) {
    return Url(
      url: map['url'] ?? "",
      type: map['type'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Url.fromJson(String source) => Url.fromMap(json.decode(source));

  @override
  String toString() => 'Url(url: $url, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Url && other.url == url && other.type == type;
  }

  @override
  int get hashCode => url.hashCode ^ type.hashCode;
}
