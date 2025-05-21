import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/bayar_sampah/models/history_transaksi_model.dart';
import 'package:satu_desa/features/bayar_sampah/services/api_services.dart';

part 'sampah_state.dart';

class SampahCubit extends Cubit<SampahState> {
  SampahCubit() : super(SampahState.initial());

  Future<void> getHistoryTransaksi() async {
    emit(SampahState(status: SampahStatus.loading));
    try {
      await Future.delayed(Duration(seconds: 2));

      String? bearerToken = LocalDataPersistance().getBearerToken();

      List<HistoryTransaksiModel> profileModel =
          await ApiServices.getHistoryTransaksi(bearerToken!);
      print(profileModel);

      final int year = 2025;

      emit(SampahState(
          status: SampahStatus.success,
          transaksiModel: profileModel,
          yearTransaction: year));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(
          SampahState(status: SampahStatus.failed, errorMessage: e.toString()));
    }
  }

  Future<void> postCreatePayment(
      {required String year, required String month}) async {
    emit(SampahState(status: SampahStatus.loading));
    try {
      String? bearerToken = LocalDataPersistance().getBearerToken();

      await Future.delayed(Duration(milliseconds: 2000));

      String snapToken =
          await ApiServices.postCretePayment(year, month, bearerToken!);

      if (snapToken.isNotEmpty) {
        emit(SampahState(
            status: SampahStatus.snapTokenObtained, snapToken: snapToken));
      } else {
        emit(SampahState(status: SampahStatus.failed));
      }
    } catch (e) {
      if (kDebugMode) print("Something Wrong!!!");
      if (kDebugMode) print(e.toString());

      print('object');

      emit(
          SampahState(status: SampahStatus.failed, errorMessage: e.toString()));
    }
  }
}
