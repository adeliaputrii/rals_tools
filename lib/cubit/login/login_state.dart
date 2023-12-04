part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  const LoginSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetCustomerInitial extends LoginState {}

class GetCustomerSuccess extends LoginState {
  final DataCustomerResponse response;

  const GetCustomerSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class GetCustomerLoading extends LoginState {}

class GetCustomerFailure extends LoginState {
  final String message;

  const GetCustomerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateLog extends LoginState {}

class CreateLogSuccess extends LoginState {}

class CreateLogLoading extends LoginState {}

class CreateLogFailure extends LoginState {
  final String message;
  const CreateLogFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
