import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/aspiration/models/aspirasi_model.dart';
import 'package:satu_desa/features/aspiration/services/api_service.dart';

part 'aspiration_state.dart';

class AspirationCubit extends Cubit<AspirationState> {
  AspirationCubit() : super(AspirationState.initial());

  Future<void> getAspirasi() async {
    emit(AspirationState(status: AspirationStatus.loading));
    try {

      String? bearerToken = LocalDataPersistance().getBearerToken();

      List<AspirasiModel> aspirasiModels =
          await ApiService.getAspirasi(bearerToken!);
      print(aspirasiModels.length);

      emit(AspirationState(
          status: AspirationStatus.success, aspirasiModels: aspirasiModels));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(AspirationState(
          status: AspirationStatus.failed, errorMessage: e.toString()));
    }
  }
}
