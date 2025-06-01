part of 'admin_cubit.dart';

enum AdminStatus { initial, loading, success, failed }

class AdminState extends Equatable {
  final AdminStatus status;
  final SummaryModel? profileModel;
  final String? errorMessage;

  const AdminState(
      {required this.status, this.profileModel, this.errorMessage});

  const AdminState.initial() : this(status: AdminStatus.initial);

  AdminState copyWith({
    AdminStatus? status,
    SummaryModel? profileModel,
    String? errorMessage,
  }) {
    return AdminState(
      status: status ?? this.status,
      profileModel: profileModel ?? this.profileModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profileModel, errorMessage];
}
