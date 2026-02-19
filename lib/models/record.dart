import 'package:uuid/uuid.dart';

enum CareType {
  breastfeeding,
  bottle,
  food,
  medicine,
  diaper,
  observation,
  symptoms,
}

extension CareTypeExtension on CareType {
  String get label {
    switch (this) {
      case CareType.breastfeeding:
        return 'Amamentação';
      case CareType.bottle:
        return 'Mamadeira';
      case CareType.food:
        return 'Alimentação';
      case CareType.medicine:
        return 'Medicamento';
      case CareType.diaper:
        return 'Fralda';
      case CareType.observation:
        return 'Recado';
      case CareType.symptoms:
        return 'Sintomas';
    }
  }

  String get unit {
    switch (this) {
      case CareType.breastfeeding:
        return 'min';
      case CareType.bottle:
        return 'ml';
      case CareType.food:
        return '';
      case CareType.medicine:
        return '';
      case CareType.diaper:
        return '';
      case CareType.observation:
        return '';
      case CareType.symptoms:
        return '';
    }
  }
}

class CareRecord {
  final String id;
  final CareType type;
  final double value; // Duração em minutos ou quantidade em ml
  final DateTime timestamp;
  final String? note;

  CareRecord({
    String? id,
    required this.type,
    required this.value,
    required this.timestamp,
    this.note,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'value': value,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
    };
  }

  factory CareRecord.fromJson(Map<String, dynamic> json) {
    return CareRecord(
      id: json['id'],
      type: CareType.values[json['type']],
      value: json['value'],
      timestamp: DateTime.parse(json['timestamp']),
      note: json['note'],
    );
  }
}
