part of 'aspiration_cubit.dart';

enum AspirationStatus { initial, loading, success, failed }

class AspirationState extends Equatable {
  final AspirationStatus status;
  final List<AspirasiModel>? aspirasiModels;
  final List<AspirasiModel>? aspirasiModelFilterMes;
  final String? errorMessage;

  const AspirationState(
      {required this.status,
      this.aspirasiModels,
      this.errorMessage,
      this.aspirasiModelFilterMes});

  const AspirationState.initial() : this(status: AspirationStatus.initial);

  AspirationState copyWith({
    AspirationStatus? status,
    List<AspirasiModel>? aspirasiModels,
    List<AspirasiModel>? aspirasiModelFilterMes,
    String? errorMessage,
  }) {
    return AspirationState(
      status: status ?? this.status,
      aspirasiModels: aspirasiModels ?? this.aspirasiModels,
      aspirasiModelFilterMes:
          aspirasiModelFilterMes ?? this.aspirasiModelFilterMes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, aspirasiModels, errorMessage, aspirasiModelFilterMes];
}
