import 'package:flutter/services.dart';

extension SpaceValidators on String {
  bool isSpaceCheck() {
    return RegExp(r'\s').hasMatch(this);
  }
}

extension NameValidators on String {
  bool isValidName2() {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(this);
  }
}

List<TextInputFormatter> get commonformattingforssoId {
  return [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
}

extension VerSionValidators on String {
  bool isValidVersion() {
    return RegExp(r'^\d+(\.\d+){2}$').hasMatch(this);
  }
}

extension ReleaseValidators on String {
  bool isValidRelease() {
    return RegExp(r'^[a-zA-Z0-9.\s\-]+$').hasMatch(this);
  }
}
