import 'package:flutter/material.dart';
import 'package:studify_flutter_challenge/presentation/screens/file_management_screen.dart';
import 'package:studify_flutter_challenge/presentation/screens/flash_screen.dart';
import 'package:studify_flutter_challenge/presentation/screens/quiz_screen.dart';
import '../core/utils/cache/unsecure_local_cache.dart';

class StudifyApp extends StatelessWidget {
  const StudifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Studify Mobile App',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: 'satoshi',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
        useMaterial3: true,
        primarySwatch: Colors.purple,
      ),
      home: const AppStartController(),
      routes: {
        FileManagementScreen.routeName: (context) => const FileManagementScreen(),
        QuizScreen.routeName: (context) => const QuizScreen()
      },
    );
  }
}

// Controller to manage initial route based on first launch
class AppStartController extends StatefulWidget{
  const AppStartController({super.key});

  @override
  State<AppStartController> createState() => _AppStartControllerState();
}

class _AppStartControllerState extends State<AppStartController>{
  final LocalCache _localCache = LocalCache();
  bool _initialized = false;
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final isFirstLaunch =  _localCache.getValue<bool>('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      await _localCache.saveValue<bool>('isFirstLaunch', false);
    }
    setState(() {
      _isFirstLaunch = isFirstLaunch;
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context){
    if(!_initialized){
      return const FileManagementScreen();
    }
    return _isFirstLaunch ? const FlashScreen() : const FileManagementScreen();
  }
}