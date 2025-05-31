part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failed,
  logOutSuccess,
  profileModelNull
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileModel? profileModel;
  final String? errorMessage;
  final LocationModel? provinces;
  final LocationModel? kabupaten;
  final LocationModel? kecamatan;
  final DistricModel? desa;

  final String? kodePos;

  const ProfileState({
    required this.status,
    this.profileModel,
    this.errorMessage,
    this.provinces,
    this.kabupaten,
    this.kecamatan,
    this.desa,
    this.kodePos,
  });

  const ProfileState.initial() : this(status: ProfileStatus.initial);

  ProfileState copyWith(
      {ProfileStatus? status,
      ProfileModel? profileModel,
      String? errorMessage,
      LocationModel? provinces,
      LocationModel? kabupaten,
      LocationModel? kecamatan,
      DistricModel? desa,
      bool setProfileModelToNull = false,
      bool setErrorMessageToNull = false,
      bool setProvincesToNull = false,
      bool setKabupatenToNull = false,
      bool setKecamatanToNull = false,
      bool setDesaToNull = false,
      DatumLocation? selectedProvince,
      DatumLocation? selectedRegency,
      DatumLocation? selectedDistrict,
      DatumVillage? selectedVillage}) {
    return ProfileState(
      status: status ?? this.status,
      profileModel:
          setProfileModelToNull ? null : profileModel ?? this.profileModel,
      errorMessage:
          setErrorMessageToNull ? null : errorMessage ?? this.errorMessage,
      provinces: setProvincesToNull ? null : provinces ?? this.provinces,
      kabupaten: setKabupatenToNull ? null : kabupaten ?? this.kabupaten,
      kecamatan: setKecamatanToNull ? null : kecamatan ?? this.kecamatan,
      desa: setDesaToNull ? null : desa ?? this.desa,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profileModel,
        errorMessage,
        provinces,
        kabupaten,
        kecamatan,
        desa,
        kodePos
      ];
}
