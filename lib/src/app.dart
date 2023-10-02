import 'package:flutter/material.dart';

import '../router.dart';
import 'utils/color.dart';
import 'utils/fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      title: 'Sakura System Solution',
      color: secondaryColor,
      theme: theme.copyWith(
        textTheme: bodyFontTheme(theme.textTheme),
        primaryColor: primaryColor,
        colorScheme: theme.colorScheme.copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
      ),
    );
  }
}
