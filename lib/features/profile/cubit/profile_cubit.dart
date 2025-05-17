import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/home_page/models/profile_model.dart';
import 'package:satu_desa/features/profile/services/api_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  Future<void> getProfile() async {
    emit(ProfileState(status: ProfileStatus.loading));

    try {
      await Future.delayed(Duration(seconds: 2));

      String? bearerToken = LocalDataPersistance().getBearerToken();

      ProfileModel profileModel = await ApiServices.getProfile(bearerToken!);
      print(profileModel);

      emit(ProfileState(
          status: ProfileStatus.success, profileModel: profileModel));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(ProfileState(
          status: ProfileStatus.failed, errorMessage: e.toString()));
    }
  }

  Future<void> postLogout() async {
    emit(ProfileState(status: ProfileStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));
      await ApiServices.postLogout(LocalDataPersistance().getBearerToken()!);

      await LocalDataPersistance.clear();

      emit(ProfileState(status: ProfileStatus.logOutSuccess));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(ProfileState(
        status: ProfileStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }
}
