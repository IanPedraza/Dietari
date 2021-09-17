import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dietari/data/domain/Url.dart';

class Tip {
  String id;
  String title;
  String body;
  List<Url> links;

  Tip({
    this.id = "",
    required this.title,
    required this.body,
    required this.links,
  });

  Tip copyWith({
    String? id,
    String? title,
    String? body,
    List<Url>? links,
  }) {
    return Tip(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'links': links.map((x) => x.toMap()).toList(),
    };
  }

  factory Tip.fromMap(Map<String, dynamic> map) {
    return Tip(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      body: map['body'] ?? "",
      links: map['links'] != null
          ? List<Url>.from(map['links']?.map((x) => Url.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tip.fromJson(String source) => Tip.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tip(id: $id, title: $title, body: $body, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tip &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        listEquals(other.links, links);
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ body.hashCode ^ links.hashCode;
  }
}
