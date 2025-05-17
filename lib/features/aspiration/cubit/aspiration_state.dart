part of 'aspiration_cubit.dart';

enum AspirationStatus { initial, loading, success, failed }

class AspirationState extends Equatable {
  final AspirationStatus status;
  final List<AspirasiModel>? aspirasiModels;
  final String? errorMessage;

  const AspirationState(
      {required this.status, this.aspirasiModels, this.errorMessage});

  const AspirationState.initial() : this(status: AspirationStatus.initial);

  @override
  List<Object?> get props => [status, aspirasiModels, errorMessage];
}
