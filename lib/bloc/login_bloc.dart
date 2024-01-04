import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta_meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<InitLogin>(_initLogin);
    on<ProsesLogin>(_prosesLogin);
    on<ProsesLogout>(_prosesLogout);
  }

  _initLogin(InitLogin event, Emitter emit) async {
    // TODO: check session
  }

  _prosesLogin(ProsesLogin event, Emitter emit) async {
    String username = event.username;
    String password = event.password;

    emit(LoginLoading());

    if (username == 'username' && password == 'password') {
      emit(const LoginSuccess(sessionToken: '123456789'));
    } else {
      emit(const LoginFailure(error: 'Login Failed'));
    }
  }

  _prosesLogout(ProsesLogout event, Emitter emit) async {
    emit(LoginLoading());
    emit(LoginInitial());
  }
}
