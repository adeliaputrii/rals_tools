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

class HomeNewsSuccess extends HomeState {
  final NewsListResponse response;

  const HomeNewsSuccess(this.response);

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
