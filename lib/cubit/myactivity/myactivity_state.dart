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

class MyActivitySuccessSubmit extends MyActivityState {
  final MyActivityResponse response;

  const MyActivitySuccessSubmit(this.response);

  @override
  List<Object?> get props => [response];
}


class MyActivitySuccessUpdate extends MyActivityState {
  final MyActivityUpdateResponse response;

  const MyActivitySuccessUpdate(this.response);

  @override
  List<Object?> get props => [response];
}

class MyActivityEditSuccess extends MyActivityState {
  final MyActivityEditResponse response;

  const MyActivityEditSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class MyActivitySuccessTask extends MyActivityState {
  final MyActivityTaskResponse response;

  const MyActivitySuccessTask(this.response);

  @override
  List<Object?> get propsProject => [response];
}

class MyActivitySuccessGetTask extends MyActivityState {
  final GetTaskResponse response;

  const MyActivitySuccessGetTask(this.response);

  @override
  List<Object?> get propsProject => [response];
}

class MyActivityLoading extends MyActivityState {}

class MyActivitySubmitFailure extends MyActivityState {
  final String message;

  const MyActivitySubmitFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class MyActivityFailure extends MyActivityState {
  final String message;

  const MyActivityFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
