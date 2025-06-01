import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/home_page/models/profile_model.dart';
import 'package:satu_desa/features/profile/models/village_model.dart';
import 'package:satu_desa/features/profile/models/location_model.dart';
import 'package:satu_desa/features/profile/services/api_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  Future<void> getProfile() async {
    emit(ProfileState(status: ProfileStatus.loading));

    try {
      await Future.delayed(Duration(seconds: 2));

      String? bearerToken = LocalDataPersistance().getBearerToken();

      String desaCode = await ApiServices.getVillageCode(bearerToken!);


      ProfileModel profileModel = await ApiServices.getProfile(bearerToken);
      print(profileModel);

      emit(ProfileState(
          status: ProfileStatus.success, profileModel: profileModel, desaCode: desaCode));
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

  Future<void> fillDataUser({
    required String kartuKeluarga,
    required String nomorInduk,
    required String nomorTelp,
    required String address,
    required String provinsi,
    required String kabupaten,
    required String kecamatan,
    required String desa,
  }) async {
    emit(ProfileState(status: ProfileStatus.loading));

    try {
      String? bearerToken = LocalDataPersistance().getBearerToken();

      await ApiServices.fillData(
          bearerToken: bearerToken!,
          kartuKeluarga: kartuKeluarga,
          nomorInduk: nomorInduk,
          nomorTelp: nomorTelp,
          address: address);

      await ApiServices.updateLocation(
          provinsi: provinsi,
          kabupaten: kabupaten,
          kecamatan: kecamatan,
          desa: desa,
          bearerToken: bearerToken);

      ProfileModel profileModel = await ApiServices.getProfile(bearerToken);

      emit(ProfileState(
        status: ProfileStatus.success,
        profileModel: profileModel,
      ));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(ProfileState(
        status: ProfileStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> fetchProvinces() async {
    emit(ProfileState(status: ProfileStatus.loading));
    try {
      final provinces = await ApiServices.getProvinces();
      emit(state.copyWith(provinces: provinces, status: ProfileStatus.success));
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> fetchRegencies(String provinceId) async {
    try {
      final regencies = await ApiServices.getRegencies(provinceId);
      emit(state.copyWith(kabupaten: regencies));
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> fetchDistricts(String regencyId) async {
    try {
      final districts = await ApiServices.getDistricts(regencyId);
      emit(state.copyWith(kecamatan: districts));
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> fetchVillages(String districtId) async {
    try {
      final villages = await ApiServices.getVillages(districtId);
      emit(state.copyWith(desa: villages));
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
}
