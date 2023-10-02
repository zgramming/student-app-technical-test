import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../utils/color.dart';
import '../utils/constant.dart';
import '../utils/fonts.dart';
import '../utils/function.dart';
import '../utils/styles.dart';
import '../view_model/app_config_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> onSubmit() async {
    try {
      final validate = _formKey.currentState?.validate() ?? false;
      if (!validate) return;

      final username = usernameController.text;
      final password = passwordController.text;

      final isSuccess =
          username == kUsernameLogin && password == kPasswordLogin;

      if (!isSuccess) {
        throw Exception('Username or password is wrong');
      }

      // Save state login to local storage
      await context
          .read<AppConfigCubit>()
          .setLogin(username: username, password: password);

      if (mounted) {
        context.goNamed(routeWelcome);
      }
    } catch (e) {
      if (!mounted) return;

      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final h = mq.size.height;
    final w = mq.size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: h,
            width: w,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Login",
                      style: headerFont.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: usernameController,
                    decoration: inputDecorationRounded().copyWith(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: inputDecorationRounded().copyWith(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onSubmit,
                      style: elevatedButtonStyle().copyWith(),
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
