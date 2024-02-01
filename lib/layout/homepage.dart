import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management_bloc/layout/dashboard.dart';
import 'package:latihan_state_management_bloc/layout/error_message.dart';
import 'package:latihan_state_management_bloc/bloc/login_bloc.dart';
import 'package:latihan_state_management_bloc/layout/loading.dart';
import 'package:latihan_state_management_bloc/layout/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return const LoginForm();
        } else if (state is LoginLoading) {
          return const LoadingIndicator();
        } else if (state is LoginSuccess) {
          return WelcomeScreen(sessionToken: state.sessionToken);
        } else if (state is LoginFailure) {
          return ErrorMessage(message: state.error);
        } else {
          return Container();
        }
      },
    );
  }
}
