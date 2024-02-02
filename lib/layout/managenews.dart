import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/managenews_bloc.dart';
import 'package:latihan_state_management_bloc/layout/listnews.dart';
import 'package:latihan_state_management_bloc/layout/loading.dart';

class ManageNews extends StatefulWidget {
  const ManageNews({super.key});

  @override
  State<ManageNews> createState() => _ManageNewsState();
}

class _ManageNewsState extends State<ManageNews> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('INIT STATE');

      context.read<ManagenewsBloc>().add(LoadListNewsEvent(keyword: ""));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagenewsBloc, ManagenewsState>(
      builder: (context, state) {
        if (state is LoadingIndicator) {
          return const LoadingIndicator();
        } else if (state is ListNewsState) {
          log('state ${state.searchText}');

          return ListNews(
            news: state.news,
            searchText: state.searchText,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
