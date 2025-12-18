import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String get serverApiUrlRadio => dotenv.env['URL_API_RADIO'] ?? "";
  static String get apiKey => dotenv.env['API_KEY'] ?? "";
  static String get secretKey => dotenv.env['SECRET_KEY'] ?? "";
}
