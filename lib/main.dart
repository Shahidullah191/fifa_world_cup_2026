import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/di/dependency_injection.dart';
import 'app/routes/app_pages.dart';
import 'app/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await DependencyInjection.init();

  runApp(const Fifa2026App());
}

class Fifa2026App extends StatelessWidget {
  const Fifa2026App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FIFA World Cup 2026',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
