enum Gender { male, female }

class Patient {
  final int id;
  final String name;
  final int age;
  final Gender gender;
  final List<int> caseIdList;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.caseIdList = const [],
  });
}
