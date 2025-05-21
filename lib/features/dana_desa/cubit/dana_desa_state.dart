part of 'dana_desa_cubit.dart';

enum DanaDesaStatus { initial, loading, success, failed }

class DanaDesaState extends Equatable {
  final DanaDesaStatus status;
  final DanaDesaModel? danaDesaModel;
  final String? errorMessage;

  const DanaDesaState(
      {required this.status,
      this.danaDesaModel,
      this.errorMessage});

  const DanaDesaState.initial() : this(status: DanaDesaStatus.initial);

  @override
  List<Object?> get props => [status, danaDesaModel, errorMessage];
}
