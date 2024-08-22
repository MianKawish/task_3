part of 'hive_bloc.dart';

enum HiveDataStatus { initial, loading, success, error }

@immutable
class HiveState {
  final String text;
  final HiveDataStatus status;
  final List hiveDataList;

  const HiveState(
      {this.text = '',
      this.status = HiveDataStatus.initial,
      this.hiveDataList = const []});

  HiveState copyWith(
      {String? text, HiveDataStatus? status, List? hiveDataList}) {
    return HiveState(
        text: text ?? this.text,
        status: status ?? this.status,
        hiveDataList: hiveDataList ?? this.hiveDataList);
  }
}
