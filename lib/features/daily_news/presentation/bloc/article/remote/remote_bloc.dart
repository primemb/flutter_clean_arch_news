import 'package:clean_arch_news/core/resources/data_state.dart';
import 'package:clean_arch_news/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch_news/features/daily_news/domain/entities/article.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'remote_event.dart';
part 'remote_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFiled) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}
