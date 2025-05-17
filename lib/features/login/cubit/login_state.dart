part of 'login_cubit.dart';

enum LoginStateStatus { initial, loading, success, failed }

class LoginState extends Equatable {
  final LoginStateStatus status;
  final LoginModel? loginModel;
  final String? errorMessage;

  const LoginState({
    required this.status,
    this.loginModel,
    this.errorMessage,
  });

  const LoginState.initial() : this(status: LoginStateStatus.initial);

  @override
  List<Object?> get props => [status, errorMessage, loginModel];
}
