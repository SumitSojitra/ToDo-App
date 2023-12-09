import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/modules/app/views/ItroScreen/ItroScreen.dart';

import 'firebase_options.dart';
import 'modules/app/views/HomeScreen/Screen/homescreen.dart';
import 'modules/app/views/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(name: '/intro', page: () => IntroScreen()),
        GetPage(
          name: "/home",
          page: () => HomeScreen(),
        ),
      ],
    ),
  );
}
