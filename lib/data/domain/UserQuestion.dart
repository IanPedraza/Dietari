import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dietari/data/domain/UserOption.dart';

class UserQuestion {
  String question;
  List<UserOption> options;

  UserQuestion({
    required this.question,
    required this.options,
  });

  UserQuestion copyWith({
    String? question,
    List<UserOption>? options,
  }) {
    return UserQuestion(
      question: question ?? this.question,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options.map((x) => x.toMap()).toList(),
    };
  }

  factory UserQuestion.fromMap(Map<String, dynamic> map) {
    return UserQuestion(
      question: map['question'],
      options: List<UserOption>.from(
          map['options']?.map((x) => UserOption.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserQuestion.fromJson(String source) =>
      UserQuestion.fromMap(json.decode(source));

  @override
  String toString() => 'UserQuestion(question: $question, options: $options)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserQuestion &&
        other.question == question &&
        listEquals(other.options, options);
  }

  @override
  int get hashCode => question.hashCode ^ options.hashCode;
}
