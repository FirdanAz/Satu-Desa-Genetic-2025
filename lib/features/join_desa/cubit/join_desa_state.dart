part of 'join_desa_cubit.dart';

enum JoinDesaStatus {initial, loading, success, failed, isMyRequest}

class JoinDesaState extends Equatable {
  final JoinDesaStatus status;
  final String? errorMessage;

  const JoinDesaState({
    required this.status,
    this.errorMessage
  });

  const JoinDesaState.initial() : this(status: JoinDesaStatus.initial);

  @override
  List<Object?> get props => [status, errorMessage];
}
