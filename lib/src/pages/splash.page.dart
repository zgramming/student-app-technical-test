import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../utils/async_state.dart';
import '../utils/color.dart';
import '../view_model/app_config_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> init() async {
    context.read<AppConfigCubit>().init();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppConfigCubit, AppConfigState>(
          listenWhen: (previous, current) => previous.onInit != current.onInit,
          listener: (context, state) {
            log("state $state");
            if (state.onInit is AsyncSuccess) {
              final isAlreadyLogin = state.item.isAlreadyLogin;
              if (isAlreadyLogin) {
                context.goNamed(routeWelcome);
              } else {
                context.goNamed(routeLogin);
              }
            }
          },
        ),
      ],
      child: const Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
