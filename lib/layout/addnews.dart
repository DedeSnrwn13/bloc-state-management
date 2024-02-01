import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/addnews_bloc.dart';
import 'package:latihan_state_management_bloc/layout/addnewsform.dart';

class NewsForm extends StatelessWidget {
  const NewsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddnewsBloc, AddnewsState>(
      builder: (context, state) {
        if (state is AddNewsInitialState) {
          return const AddNewsForm();
        } else if (state is AddNewsLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is AddNewsSuccessState) {
          return Text(state.message);
        } else if (state is AddNewsErrorState) {
          return Text('Error: ${state.error}');
        } else {
          return Container();
        }
      },
    );
  }
}
