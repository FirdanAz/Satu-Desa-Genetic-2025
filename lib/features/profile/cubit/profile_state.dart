part of 'profile_cubit.dart';

enum ProfileStatus {initial, loading, success, failed , logOutSuccess, profileModelNull}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileModel? profileModel;
  final String? errorMessage;

  const ProfileState({required this.status, this.profileModel, this.errorMessage});

  const ProfileState.initial() : this(status: ProfileStatus.initial);

  @override
  List<Object?> get props => [status, profileModel, errorMessage];
}
