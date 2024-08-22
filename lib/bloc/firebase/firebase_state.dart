part of 'firebase_bloc.dart';

enum FirebaseStatus { initial, loading, success, error }

@immutable
class FirebaseState {
  final String text;
  final FirebaseStatus status;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;

  const FirebaseState(
      {this.text = '',
      this.status = FirebaseStatus.initial,
      this.documents = const []});

  FirebaseState copyWith(
      {String? text,
      FirebaseStatus? status,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? documents}) {
    return FirebaseState(
        text: text ?? this.text,
        status: status ?? this.status,
        documents: documents ?? this.documents);
  }
}
