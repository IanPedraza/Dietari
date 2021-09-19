import 'dart:convert';

class Option {
  String name;
  int value;

  Option({
    this.name = "",
    this.value = 0,
  });

  Option copyWith({
    String? name,
    int? value,
  }) {
    return Option(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      name: map['name'] ?? "",
      value: map['value'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) => Option.fromMap(json.decode(source));

  @override
  String toString() => 'Option(name: $name, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Option && other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
