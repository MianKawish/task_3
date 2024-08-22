part of 'firebase_bloc.dart';

@immutable
sealed class FirebaseEvent {}

class TextChangedEventOfFirebase extends FirebaseEvent {
  final String text;
  TextChangedEventOfFirebase(this.text);
}

class ButtonPressedEvent extends FirebaseEvent {}

class GetUserDataEvent extends FirebaseEvent {}
