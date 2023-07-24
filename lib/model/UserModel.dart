class Users {
  Users({
    required this.name,
    required this.email,
  });

  Users.fromJson(Map<String, Object?> json)
      : this(
          name: json['Name']! as String,
          email: json['email']! as String,
        );

  final String name;
  final String email;

  Map<String, Object?> toJson() {
    return {
      'Name': name,
      'email': email,
    };
  }
}
