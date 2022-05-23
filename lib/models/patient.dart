import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:doctor_akhavan_project/models/case.dart';
import 'package:hive/hive.dart';

part 'patient.g.dart';

enum Gender { male, female }

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
  final Case? frontSideCase;
  @HiveField(5)
  final Case? backSideCase;
  @HiveField(6)
  final Case? rightSideCase;

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
  }) : id = Hive.box(patientBox).length + 1;

  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
        id: json["id"].toInt(),
        name: json["name"],
        age: json["age"].toInt(),
        gender: Gender.values[json["gender"]],
        frontSideCase: Case.fromMap(json["front_side_case"]),
        backSideCase: Case.fromMap(json["back_side_case"]),
        rightSideCase: Case.fromMap(json["right_side_case"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "age": age,
        "gender": gender.index,
        "front_side_case": frontSideCase?.toMap(),
        "back_side_case": backSideCase?.toMap(),
        "right_side_case": rightSideCase?.toMap(),
      };

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
