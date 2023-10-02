import 'package:flutter/material.dart';

@immutable
abstract class AsyncState<T> {
  const AsyncState._();

  const factory AsyncState.loading() = AsyncLoading;
  const factory AsyncState.success(T data) = AsyncSuccess;
  const factory AsyncState.error(String message) = AsyncError;

  bool get isLoading => this is AsyncLoading;
  bool get isSuccess => this is AsyncSuccess;
  bool get isError => this is AsyncError;

  T? get data => isSuccess ? (this as AsyncSuccess).data : null;

  String? get message => isError ? (this as AsyncError).message : null;
}

class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading() : super._();
}

class AsyncSuccess<T> extends AsyncState<T> {
  @override
  final T data;

  const AsyncSuccess(this.data) : super._();
}

class AsyncError<T> extends AsyncState<T> {
  @override
  final String message;

  const AsyncError(this.message) : super._();
}
