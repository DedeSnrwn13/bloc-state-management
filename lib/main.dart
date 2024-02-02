import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/addnews_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/detail_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/login_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/managenews_bloc.dart';
import 'package:latihan_state_management_bloc/layout/homepage.dart';
import 'package:latihan_state_management_bloc/repository/login_repository.dart';
import 'package:latihan_state_management_bloc/repository/news_repository.dart';

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
          BlocProvider(create: (context) => AddnewsBloc(newsRepository: context.read<NewsRepository>())),
          BlocProvider(create: (context) => ManagenewsBloc(newsRepository: context.read<NewsRepository>())),
          BlocProvider(create: (context) => DetailBloc(newsRepository: context.read<NewsRepository>()))
        ],
        child: const MaterialApp(
          title: 'Home',
          home: HomePage(),
        ),
      ),
    );
  }
}
