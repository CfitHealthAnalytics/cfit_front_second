import 'package:bloc/bloc.dart';

import 'my_event_navigation.dart';
import 'my_event_state.dart';

class MyEventCubit extends Cubit<MyEventState> {
  MyEventCubit(
    this._navigation,
  ) : super(MyEventState.empty());

  final MyEventNavigation _navigation;

  void onBack() {
    _navigation.onBack();
  }
}
