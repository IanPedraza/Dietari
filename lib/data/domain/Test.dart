import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dietari/data/domain/Question.dart';

class Test {
  String id;
  String title;
  String description;
  List questions;

  Test({
    this.id = "",
    this.title = "",
    this.description = "",
    this.questions = const <Question>[],
  });

  Test copyWith({
    String? id,
    String? title,
    String? description,
    List? questions,
  }) {
    return Test(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions,
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      questions: List.from(map['questions']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Test(id: $id, title: $title, description: $description, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Test &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        questions.hashCode;
  }
}
