// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';

part 'student.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class StudentModel extends Equatable {
  final int id;
  final String name;
  final DateTime birthDate;
  final int age;
  final GenderEnum gender;
  final String address;

  const StudentModel({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.age,
    required this.gender,
    required this.address,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      birthDate,
      age,
      gender,
      address,
    ];
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  /// Connect the generated [_$StudentModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  @override
  bool get stringify => true;

  StudentModel copyWith({
    int? id,
    String? name,
    DateTime? birthDate,
    int? age,
    GenderEnum? gender,
    String? address,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
  }
}
