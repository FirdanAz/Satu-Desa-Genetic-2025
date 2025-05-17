import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/login/service/api_service.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState.initial());

  Future<void> sendOtp(
      {required String bearerToken, required String email}) async {
    try {
      emit(OtpState(
        status: OtpStatus.loading,
      ));
      bool success = await ApiService.sendOtp(bearerToken, email);

      if (success) {
        emit(OtpState(
          status: OtpStatus.success,
        ));
      }
    } catch (e) {
      if (kDebugMode) print(e);
      emit(OtpState(status: OtpStatus.failed, errorMessage: e.toString()));
    }
  }

  Future<void> verifyOtp({
    required String bearerToken,
    required String otp,
    required String email,
  }) async {
    try {
      emit(OtpState(status: OtpStatus.loading));

      bool verifyOtpSuccess =
          await ApiService.verifyOtp(bearerToken, email, otp);

      if (verifyOtpSuccess ==  true) {
        emit(OtpState(status: OtpStatus.verifed));
      } else {
        emit(OtpState(
            status: OtpStatus.failed, errorMessage: 'OTP tidak valid'));
      }

      print(state.status);
    } catch (e) {
      if (kDebugMode) print(e);
      emit(OtpState(status: OtpStatus.failed, errorMessage: e.toString()));
    }
  }
}
