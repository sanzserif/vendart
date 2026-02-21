import 'package:equatable/equatable.dart';

/// Base use case interface
/// [Type] is the return type of the use case
/// [Params] is the input parameters type
abstract interface class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Use case that doesn't require any parameters
abstract interface class UseCaseNoParams<Type> {
  Future<Type> call();
}

/// Represents the absence of parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
