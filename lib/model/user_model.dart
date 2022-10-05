class UserModel {
  final String name;
  final String age;
  final String? image;
  UserModel({
    this.image,
    required this.name,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        age: json['age'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'image': image,
      };
}
