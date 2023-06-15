extension EnumTryByNameExtension<E extends Enum> on Iterable<E> {
  /// Finds the enum value in this list with name [name].
  ///
  /// Works like [byName] except that this function returns `null`
  /// where [byName] would throw an [ArgumentError].
  E? tryByName(String? name) {
    if (name == null) return null;

    try {
      return byName(name);
    }
    // ignore: avoid_catching_errors
    on ArgumentError {
      return null;
    }
  }
}
