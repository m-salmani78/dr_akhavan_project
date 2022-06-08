import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor_akhavan_project/models/case.dart';
import 'package:hive/hive.dart';

part 'patient.g.dart';

enum Gender { male, female }

String patientToJson(Patient data) => jsonEncode(data.toMap());

@HiveType(typeId: 1)
class Patient {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final Gender gender;
  @HiveField(4)
  Case? frontSideCase;
  @HiveField(5)
  Case? backSideCase;
  @HiveField(6)
  Case? rightSideCase;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.frontSideCase,
    this.backSideCase,
    this.rightSideCase,
  });

  Patient.init({
    required this.name,
    required this.age,
    required this.gender,
    this.frontSideCase,
    this.backSideCase,
    this.rightSideCase,
  }) : id = DateTime.now().hashCode;

  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
        id: json["id"].toInt(),
        name: json["name"],
        age: json["age"].toInt(),
        gender: Gender.values.firstWhere(
          (e) => json["gender"] == e.name,
          orElse: () => Gender.male,
        ),
        frontSideCase: Case.fromMap(json["front_side_case"]),
        backSideCase: Case.fromMap(json["back_side_case"]),
        rightSideCase: Case.fromMap(json["right_side_case"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "age": age,
        "gender": gender.name,
        "front_side_case": frontSideCase?.toMap(),
        "back_side_case": backSideCase?.toMap(),
        "right_side_case": rightSideCase?.toMap(),
      };

  Future<bool> saveToFile(String dir) async {
    try {
      final jsonFile = File('$dir/$id.json');
      await jsonFile.writeAsString(patientToJson(this));
      log('save file done sucessfully.');
      return true;
    } catch (e) {
      log('error: $e', name: 'saveToFile');
      return false;
    }
  }

  @override
  operator ==(other) {
    if (other is Patient) {
      return id == other.id;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => id.hashCode;
}
