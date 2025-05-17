part of 'splash_screen_cubit.dart';

enum SplashScreenStateStatus { loading, loggedIn, loggedOut, failed }

class SplashScreenState extends Equatable {
  final SplashScreenStateStatus status;
  final String? errorMessage;

  const SplashScreenState({
    required this.status,
    this.errorMessage,
  });

  const SplashScreenState.initial()
      : this(status: SplashScreenStateStatus.loading);

  @override
  List<Object?> get props => [status, errorMessage];
}
