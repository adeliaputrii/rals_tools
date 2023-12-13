part of 'myactivity_cubit.dart';

abstract class MyActivityState extends Equatable {
  const MyActivityState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsProject => [];
}

class MyActivityInitial extends MyActivityState {}

class MyActivitySuccess extends MyActivityState {
  final GetProjectResponse response;

  const MyActivitySuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class MyActivitySuccessTask extends MyActivityState {
  final MyActivityTaskResponse response;

  const MyActivitySuccessTask(this.response);

  @override
  List<Object?> get propsProject => [response];
}

class MyActivityLoading extends MyActivityState {}

class MyActivityFailure extends MyActivityState {
  final String message;

  const MyActivityFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
