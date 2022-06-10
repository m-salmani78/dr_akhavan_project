// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientAdapter extends TypeAdapter<Patient> {
  @override
  final int typeId = 1;

  @override
  Patient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Patient(
      id: fields[0] as int,
      name: fields[1] as String,
      age: fields[2] as int,
      gender: Gender.values[fields[3].toInt()],
      frontSideCase: fields[4] as Case?,
      backSideCase: fields[5] as Case?,
      rightSideCase: fields[6] as Case?,
      height: fields[7] as int?,
      weight: fields[8] as int?,
      activityLevel: fields[9] as int?,
      bustSize: fields[10] as int?,
      waistSize: fields[11] as int?,
      highHipSize: fields[12] as int?,
      hipSize: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Patient obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.gender.index)
      ..writeByte(4)
      ..write(obj.frontSideCase)
      ..writeByte(5)
      ..write(obj.backSideCase)
      ..writeByte(6)
      ..write(obj.rightSideCase)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.weight)
      ..writeByte(9)
      ..write(obj.activityLevel)
      ..writeByte(10)
      ..write(obj.bustSize)
      ..writeByte(11)
      ..write(obj.waistSize)
      ..writeByte(12)
      ..write(obj.highHipSize)
      ..writeByte(13)
      ..write(obj.hipSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
