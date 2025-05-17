part of 'register_cubit.dart';

enum RegisterStateStatus { initial, loading, success, failed }

class RegisterState extends Equatable {
  final RegisterStateStatus status;
  final String? errorMessage;

  const RegisterState(
      {required this.status, this.errorMessage});

  const RegisterState.initial() : this(status: RegisterStateStatus.initial);

  @override
  List<Object?> get props => [status, errorMessage];
}
