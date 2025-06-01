part of 'kabar_desa_cubit.dart';

enum KabarDesaStatus { initial, loading, success, failed }

class KabarDesaState extends Equatable {
  final KabarDesaStatus status;
  final KabarDesaModel? kabarDesaModel;
  final String? errorMessage;

  const KabarDesaState(
      {required this.status, this.kabarDesaModel, this.errorMessage});

  const KabarDesaState.initial() : this(status: KabarDesaStatus.initial);

  KabarDesaState copyWith({
    KabarDesaStatus? status,
    KabarDesaModel? kabarDesa,
    String? errorMessage,
  }) {
    return KabarDesaState(
      status: status ?? this.status,
      kabarDesaModel: kabarDesa ?? kabarDesaModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, kabarDesaModel, errorMessage];
}
