import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class EnvConfig {
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String get studifyGeminiAPIKey => dotenv.env['STUDIFY_GEMINI_API_KEY'] ?? "AIzaSyB1w1dCjPYZQT9U2NbzV9Ka8P_Fzh5T2WE";
  static GenerativeModel model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: studifyGeminiAPIKey);
}