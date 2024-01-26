sealed class Either<L, R> {
  const Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L? get left => isLeft ? (this as Left<L, R>).value : null;
  R? get right => isRight ? (this as Right<L, R>).value : null;

  T fold<T>({
    required T Function(L l) left,
    required T Function(R r) right,
  }) {
    return switch (this) {
      Left(:final value) => left(value),
      Right(:final value) => right(value),
    };
  }
}

class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;
}

class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;
}
