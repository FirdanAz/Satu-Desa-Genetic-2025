part of 'sampah_cubit.dart';

enum SampahStatus {initial, loading, failed, success, snapTokenObtained}

class SampahState extends Equatable {
  final SampahStatus status;
  final String? errorMessage;
  final int? yearTransaction;
  final List<HistoryTransaksiModel>? transaksiModel;
  final String? snapToken;

  const SampahState({
    required this.status,
    this.errorMessage,
    this.yearTransaction,
    this.transaksiModel,
    this.snapToken
  });

  const SampahState.initial() : this(status: SampahStatus.initial);

  @override
  List<Object?> get props => [status, errorMessage, yearTransaction, transaksiModel, snapToken];
}
