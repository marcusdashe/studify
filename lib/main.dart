import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify_flutter_challenge/presentation/app.dart';

import 'core/utils/cache/unsecure_local_cache.dart';
import 'env/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalCache().initialize();
  await EnvConfig.init();
  runApp(const StudifyAppWrapper());
}

class StudifyAppWrapper extends StatelessWidget {
  const StudifyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StudifyApp();
    //   MultiBlocProvider(
    //   providers: [
    //     // BlocProvider<TaskCubit>(create: (context) => TaskCubit(),),
    //   ],
    //   child: const StudifyApp(),
    // );
  }
}


