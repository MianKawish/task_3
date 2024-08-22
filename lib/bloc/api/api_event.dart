part of 'api_bloc.dart';

@immutable
sealed class ApiEvent {}

class TextChangedEventOApi extends ApiEvent {
  final String text;
  TextChangedEventOApi(this.text);
}

class GetDataOfApiEvent extends ApiEvent {}
