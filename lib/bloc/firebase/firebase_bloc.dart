import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:task_3/services/firebase_services/firebase_services.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc(this._firebaseServices) : super(const FirebaseState()) {
    on<TextChangedEventOfFirebase>(_textChangedEventOfFirebase);
    on<ButtonPressedEvent>(_buttonPressedEvent);
    on<GetUserDataEvent>(_getUserDataEvent);
  }
  final FirebaseServices _firebaseServices;

  FutureOr<void> _textChangedEventOfFirebase(
      TextChangedEventOfFirebase event, Emitter<FirebaseState> emit) {
    final String newText = event.text;

    emit(state.copyWith(text: newText));
  }

  FutureOr<void> _buttonPressedEvent(
      ButtonPressedEvent event, Emitter<FirebaseState> emit) async {
    emit(state.copyWith(status: FirebaseStatus.loading));
    await _firebaseServices.addNotesToDatabase(state.text);
    emit(state.copyWith(status: FirebaseStatus.success, text: ''));
  }

  FutureOr<void> _getUserDataEvent(
      GetUserDataEvent event, Emitter<FirebaseState> emit) async {
    final Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        await _firebaseServices.getUserData();

    await emit.forEach<QuerySnapshot<Map<String, dynamic>>>(
      stream,
      onData: (snapshot) {
        final list = snapshot.docs;
        return state.copyWith(documents: list);
      },
    );
  }
}
