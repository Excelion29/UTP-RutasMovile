class User {
  final String name;
  final String dni;

  User({
    required this.name,
    required this.dni,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      dni: json['dni'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dni': dni,
    };
  }
}