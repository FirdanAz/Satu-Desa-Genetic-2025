import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/dana_desa/models/dana_desa_model.dart';
import 'package:satu_desa/features/dana_desa/services/api_service.dart';

part 'dana_desa_state.dart';

class DanaDesaCubit extends Cubit<DanaDesaState> {
  DanaDesaCubit() : super(DanaDesaState.initial());

  Future<void> getDanaDesa() async {
    try {
      emit(DanaDesaState(status: DanaDesaStatus.loading));
      await Future.delayed(Duration(seconds: 2));

      String? bearerToken = LocalDataPersistance().getBearerToken();

      DanaDesaModel danaDesa = await ApiService.getHistoryTransaksi(bearerToken!);
      print(danaDesa);

      emit(DanaDesaState(
          status: DanaDesaStatus.success, danaDesaModel: danaDesa));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(DanaDesaState(
          status: DanaDesaStatus.failed, errorMessage: e.toString()));
    }
  }
}
