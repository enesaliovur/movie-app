import 'package:flutter_dotenv/flutter_dotenv.dart';

final class Environment {
  const Environment._();

  static Future<void> setup() async => await dotenv.load();

  static final String apiKey = dotenv.get('API_KEY');
}
