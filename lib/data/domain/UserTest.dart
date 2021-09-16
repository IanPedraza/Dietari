import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dietari/data/domain/UserQuestion.dart';

class UserTest {
  String id;
  String title;
  String description;
  List<UserQuestion> questions;
  bool isComplete;

  UserTest({
    this.id = "",
    required this.title,
    this.description = "",
    required this.questions,
    this.isComplete = false,
  });

  UserTest copyWith({
    String? id,
    String? title,
    String? description,
    List<UserQuestion>? questions,
    bool? isComplete,
  }) {
    return UserTest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions.map((x) => x.toMap()).toList(),
      'isComplete': isComplete,
    };
  }

  factory UserTest.fromMap(Map<String, dynamic> map) {
    return UserTest(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      questions: map['questions']
          ? List<UserQuestion>.from(
              map['questions']?.map((x) => UserQuestion.fromMap(x)))
          : [],
      isComplete: map['isComplete'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTest.fromJson(String source) =>
      UserTest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserTest(id: $id, title: $title, description: $description, questions: $questions, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserTest &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.questions, questions) &&
        other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        questions.hashCode ^
        isComplete.hashCode;
  }
}
