import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<BarItemIndexEvent>(_barItemIndexEvent);
  }

  FutureOr<void> _barItemIndexEvent(BarItemIndexEvent event, Emitter<HomeState> emit) {
    final int newIndex = event.currentIndex;
    emit(state.copyWith(currentIndex: newIndex));
  }
}
