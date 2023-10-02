// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../utils/enum.dart';

class FormStudentCreateOrUpdateModel extends Equatable {
  final int? id;
  final String name;
  final DateTime birthDate;
  final int age;
  final GenderEnum gender;
  final String address;
  const FormStudentCreateOrUpdateModel({
    this.id,
    required this.name,
    required this.birthDate,
    required this.age,
    required this.gender,
    required this.address,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      birthDate,
      age,
      gender,
      address,
    ];
  }

  @override
  bool get stringify => true;

  FormStudentCreateOrUpdateModel copyWith({
    int? id,
    String? name,
    DateTime? birthDate,
    int? age,
    GenderEnum? gender,
    String? address,
  }) {
    return FormStudentCreateOrUpdateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
  }
}
