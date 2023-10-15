import 'package:formz/formz.dart';

enum NonEmptyTextValidationError {
  empty;

  String get errorMessage {
    return switch (this) {
      NonEmptyTextValidationError.empty => "Не должно быть пустым",
    };
  }
}

class NonEmptyText extends FormzInput<String, NonEmptyTextValidationError> {
  const NonEmptyText.pure(String s) : super.pure(s);
  const NonEmptyText.dirty([super.value = '']) : super.dirty();

  @override
  NonEmptyTextValidationError? validator(String value) {
    return value.isEmpty ? NonEmptyTextValidationError.empty : null;
  }
}
