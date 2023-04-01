class Error {
  final String message;
  final dynamic stack;
  final String? errorCode;

  Error(this.message, {this.stack, this.errorCode});
}

class Optional<T> {
  final T? _value;

  Optional.of(T value) : _value = value;

  Optional.empty() : _value = null;

  bool get isPresent => _value != null;

  bool get isNotPresent => _value == null;

  T? get value => _value;
}

class EitherError<T> {
  final T? _value;
  final Error? _error;

  EitherError.value(T value)
      : _value = value,
        _error = null;

  EitherError.error(String message, {dynamic stack, String? errorCode})
      : _error = Error(message, stack: stack, errorCode: errorCode),
        _value = null;

  EitherError.fromError(Error error)
      : _error = error,
        _value = null;

  T? get value => _value;

  Error? get error => _error;

  bool get hasFailed => _error != null;
}

class OptionalEitherError<T> extends EitherError<Optional<T>> {
  OptionalEitherError.error(String message, {dynamic stack, String? errorCode})
      : super.error(message, stack: stack, errorCode: errorCode);

  OptionalEitherError.value(T value) : super.value(Optional.of(value));

  OptionalEitherError.empty() : super.value(Optional.empty());

  OptionalEitherError.fromError(Error error) : super.fromError(error);

  bool get isPresent => !hasFailed && _value!.isPresent;

  bool get isNotPresent => !isPresent;

  T? get optionalValue => _value!.value;
}
