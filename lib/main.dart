import 'package:flutter/material.dart';
import 'package:flutter_storage/home_page.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:flutter_storage/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator
      .registerLazySingleton<LocalStorageService>(() => SecureStorageService());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const HomePage());
  }
}
