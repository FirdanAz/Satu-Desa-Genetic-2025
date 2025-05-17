part of 'otp_cubit.dart';

enum OtpStatus { initial, loading, success, failed, verifed }

class OtpState extends Equatable {
  final OtpStatus status;
  final String? errorMessage;

  const OtpState({
    required this.status,
    this.errorMessage,
  });

  const OtpState.initial() : this(status: OtpStatus.initial);

  @override
  List<Object?> get props => [status, errorMessage];
}
