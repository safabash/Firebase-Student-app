class StudentModel {
  final String name;
  final String age;

  StudentModel({
    required this.name,
    required this.age,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        name: json['name'],
        age: json['age'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
      };
}
