import 'package:dartz/dartz.dart';

extension EitherExt<L, R> on Either<L, R> {
  R getRightOrCrash() {
    return fold((l) => throw AssertionError('Cannot get right from $this'), id);
  }

  L getLeftOrCrash() {
    return fold(id, (r) => throw AssertionError('Cannot get left from $this'));
  }

  R? getRightOrNull() {
    return fold((l) => null, id);
  }

  L? getLeftOrNull() {
    return fold(id, (r) => null);
  }

  Either<L, Unit> toUnit() {
    return fold((l) => left(l), (r) => right(unit));
  }
}

extension OptionExt<T> on Option<T> {
  T getOrCrash() {
    return fold(() => throw AssertionError('Cannot get value from $this'), id);
  }

  T? getOrNull() {
    return fold(() => null, id);
  }
}
