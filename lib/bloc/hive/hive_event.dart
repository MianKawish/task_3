part of 'hive_bloc.dart';

@immutable
sealed class HiveEvent {}

class TextChangedEventOfHive extends HiveEvent {
  final String text;
  TextChangedEventOfHive(this.text);
}

class AddDataToHive extends HiveEvent {}

class GetUserDataForHiveEvent extends HiveEvent {}
