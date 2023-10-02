// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AppConfigModel extends Equatable {
  final bool isAlreadyLogin;
  const AppConfigModel({
    required this.isAlreadyLogin,
  });

  @override
  List<Object> get props => [isAlreadyLogin];

  @override
  bool get stringify => true;

  AppConfigModel copyWith({
    bool? isAlreadyLogin,
  }) {
    return AppConfigModel(
      isAlreadyLogin: isAlreadyLogin ?? this.isAlreadyLogin,
    );
  }
}
