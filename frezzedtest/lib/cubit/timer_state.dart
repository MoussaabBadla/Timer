part of 'timer_cubit.dart';

@immutable
abstract class TimerState extends Equatable {}

class TimerInitial extends TimerState {
  @override
  List<Object?> get props => [];
}

class TimerBegin extends TimerState {
  final String hours;
  final String minutes;
  final String seconds;
  final Duration hoursduration;
  final Duration minduration;
  TimerBegin({
    required this.hoursduration,
    required this.minduration,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  List<Object?> get props => [hours, minutes, seconds ,hoursduration,minduration];
}

class TimerEnd extends TimerState {
  @override
  List<Object?> get props => [];
}
