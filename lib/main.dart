import 'package:flutter/material.dart';
import 'quiz_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const Quiz_Application());
}
