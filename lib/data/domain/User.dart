import 'dart:convert';

class User {
  String id = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String dateOfBirth = "";
  double weight = 0.0;
  double height = 0.0;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.weight,
    required this.height,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? dateOfBirth,
    double? weight,
    double? height,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weight: weight ?? this.weight,
      height: height ?? this.height,
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
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      dateOfBirth: map['dateOfBirth'],
      weight: map['weight'],
      height: map['height'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, dateOfBirth: $dateOfBirth, weight: $weight, height: $height)';
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
        other.height == height;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        dateOfBirth.hashCode ^
        weight.hashCode ^
        height.hashCode;
  }
}
