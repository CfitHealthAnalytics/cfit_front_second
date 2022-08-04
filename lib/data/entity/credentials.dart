import 'dart:convert';

class Credentials {
  final String localId;
  final String idToken;
  final String refreshToken;
  final String expiresIn;

  const Credentials({
    required this.localId,
    required this.idToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'idToken': idToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      localId: map['localId'] ?? '',
      idToken: map['idToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresIn: map['expiresIn'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Credentials.fromJson(String source) =>
      Credentials.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Credentials &&
        other.localId == localId &&
        other.idToken == idToken &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode {
    return localId.hashCode ^
        idToken.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode;
  }
}
