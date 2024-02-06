part of 'approval_return_cubit.dart';

abstract class ApprovalReturnState extends Equatable {
  const ApprovalReturnState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class ApprovalReturnInitial extends ApprovalReturnState {}

class ApprovalReturnSuccess extends ApprovalReturnState {
  final ApprovalReturnResponse response;

  const ApprovalReturnSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ApprovalReturnLoading extends ApprovalReturnState {}

class ApprovalReturnFailure extends ApprovalReturnState {
  final String message;

  const ApprovalReturnFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
