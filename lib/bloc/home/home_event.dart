part of 'home_bloc.dart';

@immutable
sealed class HomeEvent{}

class BarItemIndexEvent extends HomeEvent{
  final int currentIndex;
  BarItemIndexEvent(this.currentIndex);
}
