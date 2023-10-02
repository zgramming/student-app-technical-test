import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/model/student/form_student_create_or_update.model.dart';
import '../models/model/student/student.model.dart';
import '../models/repository/student_repository.dart';
import '../utils/async_state.dart';

class StudentState extends Equatable {
  final List<StudentModel> items;
  final AsyncState<List<StudentModel>?> onGetAll;
  final AsyncState<StudentModel?> onGetById;
  final AsyncState<List<StudentModel>?> onDelete;
  final AsyncState<List<StudentModel>?> onCreate;
  final AsyncState<List<StudentModel>?> onUpdate;
  const StudentState({
    this.items = const [],
    this.onGetAll = const AsyncSuccess(null),
    this.onGetById = const AsyncSuccess(null),
    this.onDelete = const AsyncSuccess(null),
    this.onCreate = const AsyncSuccess(null),
    this.onUpdate = const AsyncSuccess(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetAll,
      onGetById,
      onDelete,
      onCreate,
      onUpdate,
    ];
  }

  @override
  bool get stringify => true;

  StudentState copyWith({
    List<StudentModel>? items,
    AsyncState<List<StudentModel>?>? onGetAll,
    AsyncState<StudentModel?>? onGetById,
    AsyncState<List<StudentModel>?>? onDelete,
    AsyncState<List<StudentModel>?>? onCreate,
    AsyncState<List<StudentModel>?>? onUpdate,
  }) {
    return StudentState(
      items: items ?? this.items,
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onDelete: onDelete ?? this.onDelete,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
    );
  }
}

class StudentCubit extends Cubit<StudentState> {
  final StudentRepository repository;
  StudentCubit({
    required this.repository,
  }) : super(const StudentState()) {
    getAll();
  }

  Future<StudentState> getAll() async {
    emit(state.copyWith(onGetAll: const AsyncLoading()));
    final result = await repository.getAll();
    result.fold(
      (l) => emit(state.copyWith(onGetAll: AsyncError(l.message))),
      (r) => emit(
        state.copyWith(
          onGetAll: AsyncSuccess(r),
          items: r,
        ),
      ),
    );

    return state;
  }

  Future<StudentState> getById(int id) async {
    final result = await repository.getById(id);
    result.fold(
      (l) => emit(state.copyWith(onGetById: AsyncError(l.message))),
      (r) => emit(
        state.copyWith(
          onGetById: AsyncSuccess(r),
        ),
      ),
    );

    return state;
  }

  Future<StudentState> delete(int id) async {
    final result = await repository.delete(id);
    result.fold(
      (l) => emit(state.copyWith(onDelete: AsyncError(l.message))),
      (r) => emit(
        state.copyWith(
          onDelete: AsyncSuccess(r),
          items: r,
        ),
      ),
    );

    return state;
  }

  Future<StudentState> create(FormStudentCreateOrUpdateModel form) async {
    final result = await repository.create(form);
    result.fold(
      (l) => emit(state.copyWith(onCreate: AsyncError(l.message))),
      (r) => emit(
        state.copyWith(
          onCreate: AsyncSuccess(r),
          items: r,
        ),
      ),
    );

    return state;
  }

  Future<StudentState> update(
    FormStudentCreateOrUpdateModel form,
  ) async {
    final result = await repository.update(form);
    result.fold(
      (l) => emit(state.copyWith(onUpdate: AsyncError(l.message))),
      (r) => emit(
        state.copyWith(
          onUpdate: AsyncSuccess(r),
          items: r,
        ),
      ),
    );

    return state;
  }

  Future<StudentState> reset() async {
    emit(const StudentState());
    return state;
  }
}
