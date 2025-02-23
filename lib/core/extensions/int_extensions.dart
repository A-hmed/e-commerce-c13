extension IntExtensions on int {
  bool get isSuccess {
    return this >= 200 && this < 300;
  }
}
