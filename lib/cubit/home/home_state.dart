part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final GetTaskResponse response;

  const HomeSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class HomeNewsInitial extends HomeState {}

class HomeNewsSuccess extends HomeState {
  final GetNewsResponse response;

  const HomeNewsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class HomeNewsLoading extends HomeState {}

class HomeNewsFailure extends HomeState {
  final String message;

  const HomeNewsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
