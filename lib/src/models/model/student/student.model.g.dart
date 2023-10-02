// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      age: json['age'] as int,
      gender: $enumDecode(_$GenderEnumEnumMap, json['gender']),
      address: json['address'] as String,
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birth_date': instance.birthDate.toIso8601String(),
      'age': instance.age,
      'gender': _$GenderEnumEnumMap[instance.gender]!,
      'address': instance.address,
    };

const _$GenderEnumEnumMap = {
  GenderEnum.male: 'male',
  GenderEnum.female: 'female',
};
