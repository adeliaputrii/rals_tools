part of 'lspb_cubit.dart';

abstract class LspbState extends Equatable {
  const LspbState();

  @override
  List<Object?> get props => [];
}

class LspbInitial extends LspbState {}

class LspbSuccess extends LspbState {
  final LspbFormResponse response;

  const LspbSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LspbViewSuccess extends LspbState {
  final LspbViewRequestResponse response;

  const LspbViewSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LspbGetTypeSuccess extends LspbState {
  final LspbTypeDocResponse response;

  const LspbGetTypeSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LspbLoading extends LspbState {}

class LspbFailure extends LspbState {
  final String message;

  const LspbFailure({required this.message});

  @override
  List<Object?> get props => [message];
}


