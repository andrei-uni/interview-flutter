import 'package:formz/formz.dart';

// likely unneccessary
enum CountValidationError {
  empty,
  negativeOrZero,
  isDouble,
  incorrect;

  String get errorMessage {
    return switch (this) {
      CountValidationError.empty => "Не должно быть пустым",
      CountValidationError.negativeOrZero => "Должен быть больше нуля",
      CountValidationError.isDouble => "Должен быть целым",
      CountValidationError.incorrect => "Некорректное число",
    };
  }
}

class Count extends FormzInput<String, CountValidationError> {
  const Count.pure(String s) : super.pure(s);
  const Count.dirty([super.value = '']) : super.dirty();

  @override
  CountValidationError? validator(String value) {
    if (value.isEmpty) return CountValidationError.empty;

    try {
      if (int.parse(value) <= 0) return CountValidationError.negativeOrZero;
    } catch (_) {
      return CountValidationError.incorrect;
    }

    if (value.contains(".")) return CountValidationError.isDouble;

    return null;
  }
}
