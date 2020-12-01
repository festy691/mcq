import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mcq_cbt/pages/home_page.dart';
import 'package:mcq_cbt/pages/login_page.dart';
import 'package:mcq_cbt/pages/splash_screen_page.dart';
import 'package:mcq_cbt/services/subject_service.dart';
import 'package:mcq_cbt/services/user_service.dart';

void setLocator(){
  GetIt.I.registerLazySingleton(() => UserService());
  GetIt.I.registerLazySingleton(() => SubjectService());
}

void main() {
  setLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreenPage(),
    );
  }
}