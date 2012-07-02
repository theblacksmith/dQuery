
class ResultEnum {
  static final ResultEnum PASSED = const ResultEnum('passed');
  static final ResultEnum FAILED = const ResultEnum('failed');

  final String _value;

  const ResultEnum(this._value);

  String toString() {
    return this._value;
  }
}
