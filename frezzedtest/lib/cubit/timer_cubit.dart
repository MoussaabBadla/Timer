import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

DateTime dateTwo = DateTime(2023, 1, 1, 0, 0, 0);
Duration remainingtime = dateTwo.difference(DateTime.now());
Duration minduration = const Duration();
Duration hoursduration = const Duration();

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());
  bool first = true;
  Timer? countdownTimer;
  Map<String, String> tokens = {};
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setDuration() {
    Future.delayed(minduration)
        .then((value) => minduration = Duration(minutes: 1));
    Future.delayed(hoursduration)
        .then((value) => hoursduration = Duration(hours: 1));
  }

  void setCountDown() {
    int reduceSecondsBy = 1;
    int seconds = remainingtime.inSeconds - reduceSecondsBy;

    if (seconds < 0) {
      emit(TimerEnd());
    } else {
      remainingtime = Duration(seconds: seconds);
      tokens = formatDuration(remainingtime);
      if (first) {
        minduration = Duration(seconds: int.parse(tokens['seconds']!) + 1);
        hoursduration = Duration(seconds: int.parse(tokens['minutes']!) + 1);
        first = false;
      } else {}
      emit(TimerBegin(
          hoursduration: hoursduration,
          minduration: minduration,
          hours: tokens['hours']!,
          minutes: tokens['minutes']!,
          seconds: tokens['seconds']!));

      if (tokens['seconds'] == '00') {
        minduration = Duration(minutes: 1);
      }
      if (tokens['minutes'] == '00' && tokens['seconds'] == '00') {
        hoursduration = Duration(hours: 1);
      }
    }
  }
}

Map<String, String> formatDuration(Duration d) {
  var seconds = d.inSeconds;
  final days = seconds ~/ Duration.secondsPerDay;
  seconds -= days * Duration.secondsPerDay;
  final hours = seconds ~/ Duration.secondsPerHour;
  seconds -= hours * Duration.secondsPerHour;
  final minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;

  final Map<String, String> tokens = {};
  if (days != 0) {
    tokens['days'] = ('${days}');
  }
  if (tokens.isNotEmpty || hours != 0) {
    if (hours < 10) {
      tokens['hours'] = ('0${hours}');
    } else {
      tokens['hours'] = ('${hours}');
    }
  }
  if (tokens.isNotEmpty || minutes != 0) {
    if (minutes < 10) {
      tokens['minutes'] = ('0${minutes}');
    } else {
      tokens['minutes'] = ('${minutes}');
    }
  }
  if (seconds < 10) {
    tokens['seconds'] = ('0${seconds}');
  } else {
    tokens['seconds'] = ('${seconds}');
  }

  return tokens;
}
