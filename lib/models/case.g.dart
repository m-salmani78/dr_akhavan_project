// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaseAdapter extends TypeAdapter<Case> {
  @override
  final int typeId = 0;

  @override
  Case read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Case(
      patientId: fields[1] as int,
      imageName: fields[2] as String,
      dateTime: fields[3] as DateTime,
      sideMode: SideMode.values[fields[4].toInt()],
      points: (fields[5] as List)
          .map<Offset>((e) => Offset(e["dx"] ?? 0, e["dy"] ?? 0))
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Case obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.patientId)
      ..writeByte(2)
      ..write(obj.imageName)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.sideMode.index)
      ..writeByte(5)
      ..write(obj.points
          .map<Map<String, double>>((e) => {"dx": e.dx, "dy": e.dy})
          .toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
