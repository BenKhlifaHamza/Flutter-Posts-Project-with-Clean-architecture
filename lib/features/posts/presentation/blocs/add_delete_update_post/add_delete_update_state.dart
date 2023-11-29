part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

final class InitialAddDeleteUpdateState extends AddDeleteUpdateState {}

final class LoadingAddDeleteUpdateState extends AddDeleteUpdateState {}

final class ErrorAddDeleteUpdateState extends AddDeleteUpdateState {
  final String msgErr;

  const ErrorAddDeleteUpdateState({required this.msgErr});

  @override
  List<Object> get props => [msgErr];
}

final class SuccessAddDeleteUpdateState extends AddDeleteUpdateState {
  final String msgSuc;

  const SuccessAddDeleteUpdateState({required this.msgSuc});

  @override
  List<Object> get props => [msgSuc];
}
