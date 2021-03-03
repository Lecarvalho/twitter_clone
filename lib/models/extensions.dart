extension EnumParser on String {
  T toEnum<T>(Iterable<T> values) {
    return values.firstWhere(
      (e) => e.toString().split(".").last == this,
      orElse: () => null,
    );
  }
}
