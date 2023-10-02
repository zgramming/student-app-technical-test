// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../utils/failure.dart';
import '../datasource/local/student_local_datasource.dart';
import 'package:dartz/dartz.dart';

import '../model/student/form_student_create_or_update.model.dart';
import '../model/student/student.model.dart';

class StudentRepository {
  final StudentLocalDatasource localDatasource;
  const StudentRepository({
    required this.localDatasource,
  });

  Future<Either<Failure, List<StudentModel>>> getAll() async {
    try {
      final result = await localDatasource.getAllStudent();
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, StudentModel?>> getById(int id) async {
    try {
      final result = await localDatasource.getStudentById(id);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<StudentModel>>> create(
    FormStudentCreateOrUpdateModel form,
  ) async {
    try {
      final result = await localDatasource.create(form);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<StudentModel>>> update(
    FormStudentCreateOrUpdateModel form,
  ) async {
    try {
      final result = await localDatasource.update(form);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<StudentModel>>> delete(int id) async {
    try {
      final result = await localDatasource.delete(id);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
