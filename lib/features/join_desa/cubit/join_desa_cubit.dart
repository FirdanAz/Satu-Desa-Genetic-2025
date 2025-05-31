import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/join_desa/services/api_service.dart';

part 'join_desa_state.dart';

class JoinDesaCubit extends Cubit<JoinDesaState> {
  JoinDesaCubit() : super(JoinDesaState.initial());

  Future<void> checkMyRequest() async {
    emit(JoinDesaState(status: JoinDesaStatus.loading));

    try {
      await Future.delayed(Duration(seconds: 2));

      String? bearerToken = LocalDataPersistance().getBearerToken();

      bool isMyRequest = await ApiService.checkMyRequest(bearerToken!);

      if (isMyRequest) {
        emit(JoinDesaState(status: JoinDesaStatus.isMyRequest));
      }

      emit(JoinDesaState(status: JoinDesaStatus.initial));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(JoinDesaState(
          status: JoinDesaStatus.failed, errorMessage: e.toString()));
    }
  }

  Future<void> postJoin({required String kodeDesa}) async {
    emit(JoinDesaState(status: JoinDesaStatus.loading));

    try {
      await Future.delayed(Duration(seconds: 2));

      String? bearerToken = LocalDataPersistance().getBearerToken();

      bool success = await ApiService.postJoinDesa(bearerToken!, kodeDesa);

      if (success == true) {
        emit(JoinDesaState(status: JoinDesaStatus.success));
      } else {
        emit(JoinDesaState(status: JoinDesaStatus.initial));
      }
    } catch (e) {
      if (kDebugMode) print(e);
      emit(JoinDesaState(
          status: JoinDesaStatus.failed, errorMessage: e.toString()));
    }
  }
}
