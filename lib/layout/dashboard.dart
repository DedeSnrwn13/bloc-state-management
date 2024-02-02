import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/login_bloc.dart';
import 'package:latihan_state_management_bloc/layout/addnewsform.dart';
import 'package:latihan_state_management_bloc/layout/managenews.dart';

class WelcomeScreen extends StatelessWidget {
  final String sessionToken;

  const WelcomeScreen({super.key, required this.sessionToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Dede Sunarwan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome!'),
            Text('Session Token: $sessionToken'),
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(const ProsesLogout());
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewsForm(),
                  ),
                );
              },
              child: const Text('Tambah Berita'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageNews()),
                );
              },
              child: const Text('Kelola Berita'),
            ),
          ],
        ),
      ),
    );
  }
}
