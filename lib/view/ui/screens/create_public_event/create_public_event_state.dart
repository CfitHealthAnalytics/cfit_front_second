import 'package:cfit/domain/models/address.dart';
import 'package:cfit/domain/models/coordinates.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/util/extentions.dart';

class CreatePublicEventState {
  final bool loadingRequest;
  final bool editLocalization;
  final String? errorMessage;
  final CreatePublicEventStatus status;
  final String name;
  final String type;
  final String description;
  final int countMax;
  final String date;
  final String hour;
  final Address address;

  CreatePublicEventState({
    required this.loadingRequest,
    required this.editLocalization,
    this.errorMessage,
    required this.status,
    required this.name,
    required this.type,
    required this.description,
    required this.countMax,
    required this.date,
    required this.hour,
    required this.address,
  });

  factory CreatePublicEventState.empty() {
    return CreatePublicEventState(
      loadingRequest: false,
      editLocalization: false,
      status: CreatePublicEventStatus.none,
      name: '',
      type: '',
      description: '',
      countMax: 1,
      date: '',
      hour: '',
      address: Address(
        coordinates: Coordinates(),
      ),
    );
  }
  
  factory CreatePublicEventState.emptyOnlyAddress(Address address) {
    return CreatePublicEventState(
      loadingRequest: false,
      editLocalization: false,
      status: CreatePublicEventStatus.none,
      name: '',
      type: '',
      description: '',
      countMax: 1,
      date: '',
      hour: '',
      address: address,
    );
  }

  factory CreatePublicEventState.fromEvent(EventPublic event) {
    return CreatePublicEventState(
      loadingRequest: false,
      editLocalization: false,
      status: CreatePublicEventStatus.none,
      name: event.name,
      type: event.type,
      description: event.description,
      countMax: event.countMaxUsers,
      date: event.startTime.getCustomDate(withYear: true),
      hour: event.startTime.getCustomHour(),
      address: Address(
        coordinates: event.coordinates,
        city: event.city,
        neighborhood: event.neighborhood,
        number: event.number,
        street: event.street,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatePublicEventState &&
        other.loadingRequest == loadingRequest &&
        other.editLocalization == editLocalization &&
        other.errorMessage == errorMessage &&
        other.status == status &&
        other.name == name &&
        other.type == type &&
        other.description == description &&
        other.countMax == countMax &&
        other.date == date &&
        other.hour == hour &&
        other.address == address;
  }

  @override
  int get hashCode {
    return loadingRequest.hashCode ^
        editLocalization.hashCode ^
        errorMessage.hashCode ^
        status.hashCode ^
        name.hashCode ^
        type.hashCode ^
        description.hashCode ^
        countMax.hashCode ^
        date.hashCode ^
        hour.hashCode ^
        address.hashCode;
  }

  CreatePublicEventState copyWith({
    bool? loadingRequest,
    bool? editLocalization,
    String? errorMessage,
    CreatePublicEventStatus? status,
    String? name,
    String? type,
    String? description,
    int? countMax,
    String? date,
    String? hour,
    Address? address,
  }) {
    return CreatePublicEventState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      editLocalization: editLocalization ?? this.editLocalization,
      errorMessage: errorMessage,
      status: status ?? this.status,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      countMax: countMax ?? this.countMax,
      date: date ?? this.date,
      hour: hour ?? this.hour,
      address: address ?? this.address,
    );
  }
}

enum CreatePublicEventStatus { none, failed, succeeds }
