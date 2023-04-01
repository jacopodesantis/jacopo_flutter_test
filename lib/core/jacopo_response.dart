abstract class JacopoResponse {
  const JacopoResponse();
}

class SimpleResponse<T> extends JacopoResponse {
  final T value;

  const SimpleResponse._({required this.value});

  factory SimpleResponse.fromValue(T value) => SimpleResponse._(value: value);
}
