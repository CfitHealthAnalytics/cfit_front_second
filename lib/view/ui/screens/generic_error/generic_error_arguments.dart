import 'dart:convert';

enum ErrorType { unknown, conectaToken }

class GenericErrorArguments {
  final ErrorType type;
  GenericErrorArguments({
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(),
    };
  }

  factory GenericErrorArguments.fromMap(Map<String, dynamic> map) {
    return GenericErrorArguments(
      type: map['type'] == ErrorType.conectaToken.toString()
          ? ErrorType.conectaToken
          : ErrorType.unknown,
    );
  }

  String toJson() => json.encode(toMap());

  factory GenericErrorArguments.fromJson(String source) =>
      GenericErrorArguments.fromMap(json.decode(source));
}
