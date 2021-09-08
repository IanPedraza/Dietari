import 'dart:convert';

class UserOption {
  String name;
  int value;
  bool isSelected;

  UserOption({
    this.name = "",
    this.value = 0,
    this.isSelected = false,
  });

  UserOption copyWith({
    String? name,
    int? value,
    bool? isSelected,
  }) {
    return UserOption(
      name: name ?? this.name,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
      'isSelected': isSelected,
    };
  }

  factory UserOption.fromMap(Map<String, dynamic> map) {
    return UserOption(
      name: map['name'],
      value: map['value'],
      isSelected: map['isSelected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserOption.fromJson(String source) =>
      UserOption.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserOption(name: $name, value: $value, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserOption &&
        other.name == name &&
        other.value == value &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ isSelected.hashCode;
}
