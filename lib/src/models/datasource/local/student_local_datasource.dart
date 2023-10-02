// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../database/my_database.dart';
import '../../model/student/form_student_create_or_update.model.dart';
import '../../model/student/student.model.dart';

class StudentLocalDatasource {
  final MyDatabase database;
  const StudentLocalDatasource({
    required this.database,
  });

  Future<List<StudentModel>> getAllStudent() async {
    return await database.getAllStudent();
  }

  Future<StudentModel?> getStudentById(int id) async {
    return await database.getStudentById(id);
  }

  Future<List<StudentModel>> create(FormStudentCreateOrUpdateModel form) async {
    return await database.create(form);
  }

  Future<List<StudentModel>> update(FormStudentCreateOrUpdateModel form) async {
    return await database.update(form);
  }

  Future<List<StudentModel>> delete(int id) async {
    return await database.delete(id);
  }
}
