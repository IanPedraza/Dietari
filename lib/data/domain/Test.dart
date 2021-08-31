import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dietari/data/domain/Question.dart';

class Test {
  String id;
  String title;
  String description;
  List<Question> questions;

  Test({
    this.id = "",
    required this.title,
    this.description = "",
    required this.questions,
  });

  Test copyWith({
    String? id,
    String? title,
    String? description,
    List<Question>? questions,
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
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      questions: List<Question>.from(
          map['questions']?.map((x) => Question.fromMap(x))),
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
