
extension Casting<T> on T {
  /// safe-casting on every instance type
  /// without throwing a casting exception, if failed then return null
  ///
  /// ```dart
  ///   class Parent {}
  ///   class Child extends Parent {}
  ///
  ///   var child = Child();
  ///   print(child.as<Parent>() != null) // true
  /// ```
  CastingType? as<CastingType>() {
    return this is CastingType ? (this as CastingType) : null;
  }
}

mixin UpCasting<Parent> {
  Parent toParent();
}
