part of 'meeting_cubit.dart';

sealed class MeetingState extends Equatable {
  const MeetingState();

  @override
  List<Object> get props => [];
}

final class MeetingInitial extends MeetingState {}
