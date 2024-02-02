part of 'managenews_bloc.dart';

@immutable
sealed class ManagenewsState extends Equatable {}

class ManagenewsInitialState extends ManagenewsState {
  @override
  List<Object> get props => [];
}

class ManagenewsLoadingState extends ManagenewsState {
  @override
  List<Object> get props => [];
}

class ManagenewsSuccessState extends ManagenewsState {
  final String message;

  ManagenewsSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class ManagenewsErrorState extends ManagenewsState {
  final String error;

  ManagenewsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class LoadingNewsState extends ManagenewsState {
  @override
  List<Object?> get props => [];
}

class ListNewsState extends ManagenewsState {
  final List news;
  final String searchText;

  ListNewsState({required this.news, required this.searchText});

  @override
  List<Object?> get props => [];
}
