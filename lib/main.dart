import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';

import 'src/app.dart';
import 'src/models/database/my_database.dart';
import 'src/view_model/app_config_cubit.dart';
import 'src/view_model/student_cubit.dart';

// factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
//     _$AuthenticationResponseModelFromJson(json);

// /// Connect the generated [_$AuthenticationResponseModelToJson] function to the `toJson` method.
// Map<String, dynamic> toJson() => _$AuthenticationResponseModelToJson(this);

// dart run build_runner watch --delete-conflicting-outputs

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init MyDatabase
  await MyDatabase().init();

  // Init Injection
  setupInjection();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<StudentCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AppConfigCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
