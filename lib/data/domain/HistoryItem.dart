import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryItem {
  String id;
  num imc;
  num weight;
  num height;
  Timestamp date;

  HistoryItem({
    required this.id,
    required this.imc,
    required this.weight,
    required this.height,
    required this.date,
  });

  HistoryItem copyWith({
    String? id,
    num? imc,
    num? weight,
    num? height,
    Timestamp? date,
  }) {
    return HistoryItem(
      id: id ?? this.id,
      imc: imc ?? this.imc,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imc': imc,
      'weight': weight,
      'height': height,
      'date': date,
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      id: map['id'],
      imc: map['imc'],
      weight: map['weight'],
      height: map['height'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryItem.fromJson(String source) =>
      HistoryItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryItem(id: $id, imc: $imc, weight: $weight, height: $height, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryItem &&
        other.id == id &&
        other.imc == imc &&
        other.weight == weight &&
        other.height == height &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imc.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        date.hashCode;
  }
}
