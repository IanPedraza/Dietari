import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String dateOfBirth;
  num weight;
  num height;
  num imc;
  String status;
  List<String> tips;

  static const FIELD_FIRST_NAME = "firstName";
  static const FIELD_LAST_NAME = "lastName";
  static const FIELD_WEIGHT = "weight";
  static const FIELD_HEIGHT = "height";

  User({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.dateOfBirth = "",
    this.weight = 0.0,
    this.height = 0.0,
    this.imc = 0.0,
    this.status = "",
    required this.tips,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? dateOfBirth,
    double? weight,
    double? height,
    double? imc,
    String? status,
    List<String>? tips,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      imc: imc ?? this.imc,
      status: status ?? this.status,
      tips: tips ?? this.tips,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'weight': weight,
      'height': height,
      'imc': imc,
      'status': status,
      'tips': tips,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      dateOfBirth: map['dateOfBirth'] ?? "",
      weight: map['weight'] ?? 0.0,
      height: map['height'] ?? 0.0,
      imc: map['imc'] ?? 0.0,
      status: map['status'] ?? "",
      tips: map['tips'] != null ? List<String>.from(map['tips']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, dateOfBirth: $dateOfBirth, weight: $weight, height: $height, imc: $imc, status: $status, tips: $tips)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.dateOfBirth == dateOfBirth &&
        other.weight == weight &&
        other.height == height &&
        other.imc == imc &&
        other.status == status &&
        listEquals(other.tips, tips);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        dateOfBirth.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        imc.hashCode ^
        status.hashCode ^
        tips.hashCode;
  }
}
