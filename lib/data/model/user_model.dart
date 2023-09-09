class UserResponse {
  final String message;
  final User user;
  final String accessToken;
  final String tokenType;

  UserResponse({
    required this.message,
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
    );
  }
}

class User {
  final String name;
  final String email;
  final int id;

  User({
    required this.name,
    required this.email,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}
