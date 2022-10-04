import 'package:cfit/data/models/auth.dart';
import 'package:cfit/data/models/bio.dart';
import 'package:cfit/data/models/events.dart';
import 'package:cfit/data/models/user.dart';
import 'package:cfit/data/repository/auth.dart';
import 'package:cfit/data/repository/bio.dart';
import 'package:cfit/data/repository/events.dart';
import 'package:cfit/data/repository/user.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/auto_configure_user_use_case.dart';
import 'package:cfit/domain/use_cases/bio_info_use_case.dart';
import 'package:cfit/domain/use_cases/categories_event_use_case.dart';
import 'package:cfit/domain/use_cases/complete_account_use_case.dart';
import 'package:cfit/domain/use_cases/confirmation_event_in_city_use_case.dart';
import 'package:cfit/domain/use_cases/confirmation_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/create_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/decline_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/delete_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/edit_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/events_in_city_use_case.dart';
import 'package:cfit/domain/use_cases/events_public_use_case.dart';
import 'package:cfit/domain/use_cases/feed_use_case.dart';
import 'package:cfit/domain/use_cases/get_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/initialization_by_conecta_use_case.dart';
import 'package:cfit/domain/use_cases/initialization_use_case.dart';
import 'package:cfit/domain/use_cases/logout_use_case.dart';
import 'package:cfit/domain/use_cases/recover_password_use_case.dart';
import 'package:cfit/domain/use_cases/register_use_case.dart';
import 'package:cfit/domain/use_cases/schedule_event_in_city_use_case.dart';
import 'package:cfit/domain/use_cases/schedule_event_public_use_case.dart';
import 'package:cfit/external/api/authenticated_client.dart';
import 'package:cfit/external/api/unauthenticated_client.dart';
import 'package:cfit/external/factory/api.dart';
import 'package:cfit/external/storage/storage_client.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/use_cases/login_use_case.dart';
import '../external/models/storage.dart';
import 'singleton.dart';

final storageImp =
    StorageImpl(sharedPreferences: SharedPreferences.getInstance());

extension DependencyInjection on BuildContext {
  Storage storage() {
    return storageImp;
  }

  User getUser() {
    return Singleton().user;
  }

  UnauthenticatedClient unauthenticatedClient() {
    return UnauthenticatedClient(
      baseUri: AppConstants.BASE_URL,
      factory: ApiResponseFactory(),
    );
  }

  AuthenticatedClient authenticatedClient() {
    return AuthenticatedClient(
        baseUri: AppConstants.BASE_URL,
        factory: ApiResponseFactory(),
        storage: storage());
  }

  AuthRepository authRepository() {
    return AuthRepositoryImpl(
      client: unauthenticatedClient(),
      storage: storage(),
    );
  }

  UserRepository userRepository() {
    return UserRepositoryImpl(
      client: authenticatedClient(),
      storage: storage(),
    );
  }

  EventsRepository eventsRepository() {
    return EventsRepositoryImpl(
      authenticatedClient(),
      storage(),
    );
  }

  BioInfoRepository bioInfoRepository() {
    return BioInfoRepositoryImpl(
      authenticatedClient(),
    );
  }

  InitializationUseCase initializationUseCase() {
    return InitializationUseCase(
      authRepository: authRepository(),
    );
  }

  InitializationByConectaUseCase initializationByConectaUseCase() {
    return InitializationByConectaUseCase(
      authRepository: authRepository(),
      userRepository: userRepository(),
    );
  }

  AutoConfigureUserUseCase autoConfigureUserUseCase() {
    return AutoConfigureUserUseCase(
      authRepository: authRepository(),
      userRepository: userRepository(),
    );
  }

  LoginUseCase loginUseCase() {
    return LoginUseCase(
      authRepository(),
    );
  }

  RegisterUseCase registerUseCase() {
    return RegisterUseCase(
      authRepository(),
    );
  }

  FeedUseCase feedUseCase() {
    return FeedUseCase(
        userRepository: userRepository(),
        setUser: (User user) => Singleton().user = user);
  }

  LogoutUseCase logoutUseCase() {
    return LogoutUseCase(
      authRepository(),
    );
  }

  EventsInCityUseCase eventsInCityUseCase() {
    return EventsInCityUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  ScheduleEventCityInCityUseCase scheduleEventsInCityUseCase() {
    return ScheduleEventCityInCityUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  ScheduleEventPublicInCityUseCase scheduleEventsPublicUseCase() {
    return ScheduleEventPublicInCityUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  ConfirmationEventInCityUseCase confirmationEventInCityUseCase() {
    return ConfirmationEventInCityUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  EventsPublicUseCase eventsPublicUseCase() {
    return EventsPublicUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  CategoriesEventUseCase categoriesEventUseCase() {
    return CategoriesEventUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  CreateEventPublicUseCase createEventPublicUseCase() {
    return CreateEventPublicUseCase(
      eventsRepository(),
    );
  }

  EditEventPublicUseCase editEventPublicUseCase() {
    return EditEventPublicUseCase(
      eventsRepository(),
    );
  }

  GetEventPublicUseCase getEventPublicUseCase() {
    return GetEventPublicUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  DeleteEventPublicUseCase deleteEventPublicUseCase() {
    return DeleteEventPublicUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  ConfirmationEventPublicUseCase confirmationEventPublicUseCase() {
    return ConfirmationEventPublicUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  DeclineEventPublicUseCase declineEventPublicUseCase() {
    return DeclineEventPublicUseCase(
      eventsRepository: eventsRepository(),
    );
  }

  BioInfoUseCase bioInfoUseCase() {
    return BioInfoUseCase(
      bioInfoRepository: bioInfoRepository(),
    );
  }

  RecoverPasswordUseCase recoverPasswordUseCase() {
    return RecoverPasswordUseCase(
      authRepository(),
    );
  }

  CompleteAccountUseCase completeAccountUseCase() {
    return CompleteAccountUseCase(
      authRepository(),
      userRepository(),
    );
  }
}
