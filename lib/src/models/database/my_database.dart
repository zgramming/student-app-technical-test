import 'package:sqflite/sqflite.dart';

import '../../utils/enum.dart';
import '../model/student/form_student_create_or_update.model.dart';
import '../model/student/student.model.dart';

class MyDatabase {
  static final MyDatabase _myDatabase = MyDatabase._internal();

  factory MyDatabase() {
    return _myDatabase;
  }

  MyDatabase._internal();

  static const String _databaseName = 'my_database.db';
  static const int _databaseVersion = 1;

  static const String _studentTable = 'students';

  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnBirthDate = 'birth_date';
  static const String _columnAge = 'age';
  static const String _columnGender = "gender";
  static const String _columnAddress = 'address';

  late Database _database;

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_studentTable (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_columnName TEXT NOT NULL,
        $_columnBirthDate TEXT NOT NULL,
        $_columnAge INTEGER NOT NULL,
        $_columnGender TEXT NOT NULL,
        $_columnAddress TEXT NOT NULL
      )
    ''');
  }

  Future<void> init() async {
    final String databasePath = await getDatabasesPath();
    final String path = '$databasePath/$_databaseName';

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Get All Student Data
  Future<List<StudentModel>> getAllStudent() async {
    final result = await _database.query(_studentTable);
    final student = result.map((e) => StudentModel.fromJson(e)).toList();
    return student;
  }

  // Get Student Data By Id
  Future<StudentModel?> getStudentById(int id) async {
    final result = await _database.query(
      _studentTable,
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    final student = result.map((e) => StudentModel.fromJson(e)).first;
    return student;
  }

  // Insert Student Data
  Future<List<StudentModel>> create(FormStudentCreateOrUpdateModel form) async {
    await _database.insert(
      _studentTable,
      {
        _columnName: form.name,
        _columnBirthDate: form.birthDate.toIso8601String(),
        _columnAge: form.age,
        _columnGender: form.gender.valueString,
        _columnAddress: form.address,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final student = await getAllStudent();
    return student;
  }

  // Update Student Data
  Future<List<StudentModel>> update(
    FormStudentCreateOrUpdateModel form,
  ) async {
    await _database.update(
      _studentTable,
      {
        _columnName: form.name,
        _columnBirthDate: form.birthDate.toIso8601String(),
        _columnAge: form.age,
        _columnGender: form.gender.valueString,
        _columnAddress: form.address,
      },
      where: '$_columnId = ?',
      whereArgs: [form.id],
    );

    final student = await getAllStudent();
    return student;
  }

  // Delete Student Data

  Future<List<StudentModel>> delete(int id) async {
    await _database.delete(
      _studentTable,
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    final student = await getAllStudent();
    return student;
  }
}
