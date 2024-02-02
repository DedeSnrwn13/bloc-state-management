import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:latihan_state_management_bloc/repository/news_repository.dart';
import 'package:equatable/equatable.dart';

part 'managenews_event.dart';
part 'managenews_state.dart';

class ManagenewsBloc extends Bloc<ManagenewsEvent, ManagenewsState> {
  NewsRepository newsRepository;

  ManagenewsBloc({required this.newsRepository}) : super(ManagenewsLoadingState()) {
    on<LoadListNewsEvent>(_listnews);
  }

  _listnews(LoadListNewsEvent event, Emitter emit) async {
    String key = event.keyword;

    emit(LoadingNewsState());
    List res = await newsRepository.getNewsList(key);

    emit(ListNewsState(news: res, searchText: key));
  }
}
