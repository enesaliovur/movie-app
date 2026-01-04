import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

typedef FailureOr<T> = Either<Failure, T>;

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class BadRequestFailure extends Failure {
  const BadRequestFailure();
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure();
}

class ConnectionFailure extends Failure {
  const ConnectionFailure();
}

class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

class UnknownFailure extends Failure {
  const UnknownFailure();
}

class TypeFailure extends Failure {
  const TypeFailure();
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}
