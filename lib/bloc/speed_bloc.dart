import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedometer/bloc/speed_event.dart';

import 'speed_state.dart';

class SpeedBloc extends Bloc<ChangeSpeed, SpeedState> {
  SpeedBloc() : super(SpeedInitial()) {
    on<ChangeSpeed>((event, emit) {
      if (event.speed > 0.02) {
        emit(OverSpeed(event.speed));
      } else {
        emit(CorrectSpeed(event.speed));
      }
    });
  }
}
