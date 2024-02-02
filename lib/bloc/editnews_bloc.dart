import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:latihan_state_management_bloc/repository/news_repository.dart';

part 'editnews_event.dart';
part 'editnews_state.dart';

class EditnewsBloc extends Bloc<EditnewsEvent, EditnewsState> {
  final NewsRepository newsRepository;

  EditnewsBloc({required this.newsRepository}) : super(EditnewsInitial()) {
    on<SetInit>(_setInit);
    on<ClickEdit>(_editnews);
  }

  _setInit(SetInit event, Emitter emit) {
    emit(EditnewsInitial());
  }

  _editnews(ClickEdit event, Emitter emit) async {
    try {
      // state 1
      emit(LoadingEdit());

      bool result = await newsRepository.editNews(
        id: event.id,
        title: event.title,
        content: event.content,
        date: event.date,
        image: event.image,
      );

      // state 2 if success
      if (result) {
        emit(SuccessEdit(message: "Berita ${event.title} Berhasil di ubah"));
      } else {
        emit(ErrorEdit(error: 'Error: Gagal Merubah Berita'));
      }
    } catch (error) {
      // state 2 if error
      emit(ErrorEdit(error: 'Error: $error'));
    }
  }
}
