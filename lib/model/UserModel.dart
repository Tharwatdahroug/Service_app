class Users {
  Users({
    required this.name,
    required this.email,
    required this.type,
  });

  Users.fromJson(Map<String, Object?> json)
      : this(
          name: json['Name']! as String,
          email: json['email']! as String,
          type: json['Type']! as String,
        );

  final String name;
  final String email;
  final String type;

  Map<String, Object?> toJson() {
    return {
      'Name': name,
      'email': email,
      'Type': type,
    };
  }
}
