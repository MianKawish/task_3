import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_3/model/api_model/news_model.dart';
import 'package:task_3/services/api/api_services.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(this._apiServices) : super(const ApiState()) {
    on<TextChangedEventOApi>(_textChangedEventOApi);
    on<GetDataOfApiEvent>(_getDataOfApiEvent);
  }
  final ApiServices _apiServices;

  FutureOr<void> _textChangedEventOApi(
      TextChangedEventOApi event, Emitter<ApiState> emit) {
    final String newText = event.text;

    emit(state.copyWith(text: newText));
    add(GetDataOfApiEvent());
  }

  FutureOr<void> _getDataOfApiEvent(
      GetDataOfApiEvent event, Emitter<ApiState> emit) async {
    try {
      emit(state.copyWith());
      final data = await _apiServices.getData();
      if (state.text.isEmpty) {
        emit(state.copyWith(newsModel: data));
      } else {
        final filteredArticles = data.articles?.where((article) {
              final titleMatch = article.title
                      ?.toLowerCase()
                      .contains(state.text.toLowerCase()) ??
                  false;
              final authorMatch = article.author
                      ?.toLowerCase()
                      .contains(state.text.toLowerCase()) ??
                  false;
              return titleMatch || authorMatch;
            }).toList() ??
            [];

        final newModel = NewsModel(
          status: data.status,
          totalResults: filteredArticles.length,
          articles: filteredArticles,
        );

        emit(state.copyWith(newsModel: newModel));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
