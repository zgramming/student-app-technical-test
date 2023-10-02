import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../view_model/app_config_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static void onLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Remove state login from local storage
              await context.read<AppConfigCubit>().setLogout();

              if (!context.mounted) return;

              context.goNamed(routeLogin);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Icon(Icons.logout),
              ),
              title: const Text('Logout'),
              onTap: () => onLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
