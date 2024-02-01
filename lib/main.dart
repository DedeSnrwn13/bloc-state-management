import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/login_bloc.dart';
import 'package:latihan_state_management_bloc/layout/homepage.dart';
import 'package:latihan_state_management_bloc/repository/login_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(loginRepository: context.read<LoginRepository>())
              ..add(
                const InitLogin(),
              ),
          ),
        ],
        child: const MaterialApp(
          title: 'Home',
          home: HomePage(),
        ),
      ),
    );
  }
}
