class Tokenization {
  final String accessToken;
  final String? refreshToken;

  Tokenization({
    required this.accessToken,
    this.refreshToken,
  });

  factory Tokenization.fromJson(Map<String, dynamic> map) {
    return Tokenization(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }
}
