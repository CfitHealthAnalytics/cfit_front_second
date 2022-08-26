import 'dart:convert';

class SelectLocalizationArguments {
  SelectLocalizationArguments({
    required this.toCreateEvent,
  });
  final bool toCreateEvent;

  Map<String, dynamic> toMap() {
    return {
      'to_create_event': toCreateEvent,
    };
  }

  factory SelectLocalizationArguments.fromMap(Map<String, dynamic> map) {
    return SelectLocalizationArguments(
      toCreateEvent: map['to_create_event'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectLocalizationArguments.fromJson(String source) =>
      SelectLocalizationArguments.fromMap(json.decode(source));
}
