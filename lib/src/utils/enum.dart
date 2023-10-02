enum GenderEnum { male, female }

extension GenderEnumEXT on GenderEnum {
  String get valueString {
    switch (this) {
      case GenderEnum.male:
        return 'male';
      case GenderEnum.female:
        return 'female';
      default:
        return '';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case GenderEnum.male:
        return "Male";
      case GenderEnum.female:
        return "Female";
      default:
        return "";
    }
  }
}

// Path: lib/src/utils/enum.dart
