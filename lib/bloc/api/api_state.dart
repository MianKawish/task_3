part of 'api_bloc.dart';

@immutable
class ApiState {
  final String text;
  final NewsModel? newsModel;

  const ApiState({this.text = '', this.newsModel});

  ApiState copyWith({String? text, NewsModel? newsModel}) {
    return ApiState(
      text: text ?? this.text,
      newsModel: newsModel ?? this.newsModel,
    );
  }
}
