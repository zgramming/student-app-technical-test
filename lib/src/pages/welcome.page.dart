import 'package:flutter/material.dart';

import 'setting.page.dart';
import 'student.page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const tabs = [
    Tab(text: 'Student'),
    Tab(text: 'Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          bottom: const TabBar(
            tabs: tabs,
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            StudentPage(),
            SettingPage(),
          ],
        ),
      ),
    );
  }
}
