class ConfirmationEventCityRequest {
  final String eventId;
  final List<String> usersConfirmed;

  ConfirmationEventCityRequest({
    required this.eventId,
    required this.usersConfirmed,
  });
}
