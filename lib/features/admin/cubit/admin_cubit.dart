import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/admin/models/summary_model.dart';
import 'package:satu_desa/features/admin/services/api_service.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminState.initial());

  Future<void> getSummaryDashboard() async {
    try {
      emit(AdminState(status: AdminStatus.loading));
      await Future.delayed(Duration(seconds: 2));

      String? bearerToken = LocalDataPersistance().getBearerToken();

      SummaryModel summaryModel = await ApiService.getSummary(bearerToken!);
      print(summaryModel);

      emit(AdminState(status: AdminStatus.success, profileModel: summaryModel));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(AdminState(status: AdminStatus.failed, errorMessage: e.toString()));
    }
  }
}
