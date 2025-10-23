import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class EnvConfig {
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String get studifyGeminiAPIKey => dotenv.env['STUDIFY_GEMINI_API_KEY'] ?? "";
  static var model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: studifyGeminiAPIKey);

}