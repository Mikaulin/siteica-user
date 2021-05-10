bool timeExceeded(int _timeInMilliseconds, int _limitMilliseconds) {
  int _now = DateTime.now().millisecondsSinceEpoch;
  int _comparedValue = _timeInMilliseconds + _limitMilliseconds;

  return _comparedValue >= _now;
}