import 'package:ecom/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:ecom/route/route_constants.dart';
import 'package:ecom/route/router.dart' as router;
import 'package:ecom/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ecom Template by The Flutter Way',
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      initialRoute: onbordingScreenRoute,
    );
  }
}
