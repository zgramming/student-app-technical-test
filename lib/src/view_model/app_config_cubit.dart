// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/model/app_config.model.dart';
import '../utils/async_state.dart';
import '../utils/flutter_secure_storage.dart';

class AppConfigState extends Equatable {
  final AppConfigModel item;
  final AsyncState<bool?> onInit;
  const AppConfigState({
    this.item = const AppConfigModel(isAlreadyLogin: false),
    this.onInit = const AsyncState.success(null),
  });

  @override
  List<Object> get props => [item, onInit];

  @override
  bool get stringify => true;

  AppConfigState copyWith({
    AppConfigModel? item,
    AsyncState<bool?>? onInit,
  }) {
    return AppConfigState(
      item: item ?? this.item,
      onInit: onInit ?? this.onInit,
    );
  }
}

class AppConfigCubit extends Cubit<AppConfigState> {
  // ignore: prefer_const_constructors
  AppConfigCubit() : super(AppConfigState()) {
    init();
  }

  Future<void> init() async {
    try {
      emit(state.copyWith(onInit: const AsyncState.loading()));
      final result = await FlutterSecureStorageUtils.getUserAuth();
      emit(state.copyWith(
        onInit: AsyncState.success(result),
        item: state.item.copyWith(isAlreadyLogin: result != null),
      ));
    } catch (e) {
      emit(state.copyWith(onInit: AsyncState.error(e.toString())));
      log(e.toString());
    }
  }

  Future<void> setLogin({
    required String username,
    required String password,
  }) async {
    try {
      await FlutterSecureStorageUtils.setUserAuth(
        username: username,
        password: password,
      );
      final item = state.item.copyWith(isAlreadyLogin: true);
      emit(state.copyWith(item: item));
    } catch (e) {
      emit(state.copyWith());
    }
  }

  Future<void> setLogout() async {
    try {
      await FlutterSecureStorageUtils.removeUserAuth();
      final item = state.item.copyWith(isAlreadyLogin: false);
      emit(state.copyWith(item: item));
    } catch (e) {
      emit(state.copyWith());
    }
  }
}
