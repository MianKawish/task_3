import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/hive/hive_services.dart';

part 'hive_event.dart';
part 'hive_state.dart';

class HiveBloc extends Bloc<HiveEvent, HiveState> {
  HiveBloc(this._hiveServices) : super(const HiveState()) {
    on<TextChangedEventOfHive>(_textChangedEventOfHive);
    on<AddDataToHive>(_addDataToHive);
    on<GetUserDataForHiveEvent>(_getUserDataForHiveEvent);
  }

  FutureOr<void> _textChangedEventOfHive(
      TextChangedEventOfHive event, Emitter<HiveState> emit) {
    final String newText = event.text;
    emit(state.copyWith(text: newText));
  }

  final HiveServices _hiveServices;

  FutureOr<void> _addDataToHive(
      AddDataToHive event, Emitter<HiveState> emit) async {
    emit(state.copyWith(status: HiveDataStatus.loading));
    try {
      await _hiveServices.addData(state.text);

      final list = await _hiveServices.getData();

      emit(state.copyWith(status: HiveDataStatus.success, hiveDataList: list));
    } catch (e) {
      emit(state.copyWith(status: HiveDataStatus.error));
    }
  }

  FutureOr<void> _getUserDataForHiveEvent(
      GetUserDataForHiveEvent event, Emitter<HiveState> emit) async {
    final list = await _hiveServices.getData();
    emit(state.copyWith(hiveDataList: list));
  }
}
