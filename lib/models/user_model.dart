class UserModel {
  final int? id;
  final String email;
  final String password;
  final String name;
  final String gender;
  final int point;
  final String rank;
  final String profile;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.point,
    required this.rank,
    required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      gender: json['gender'],
      point: json['point'],
      rank: json['rank'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'gender': gender,
      'point': point,
      'rank': rank,
      'profile': profile,
    };
  }
}
