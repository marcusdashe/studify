import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify_flutter_challenge/presentation/app.dart';

void main() {
  runApp(const StudifyAppWrapper());
}

class StudifyAppWrapper extends StatelessWidget {
  const StudifyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<TaskCubit>(create: (context) => TaskCubit(),),
      ],
      child: const StudifyApp(),
    );
  }
}


