part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String sessionToken;

  const LoginSuccess({required this.sessionToken});
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});
}
