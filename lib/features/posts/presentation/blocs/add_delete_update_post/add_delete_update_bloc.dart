import '../../../../../core/errors/failures.dart';
import '../../../../../core/errors/failures_messages.dart';
import '../../../../../core/success/success_messages.dart';
import '../../../domaine/entities/post_entitie.dart';
import '../../../domaine/use_cases/add_post_uc.dart';
import '../../../domaine/use_cases/delete_post_uc.dart';
import '../../../domaine/use_cases/update_post_uc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUC addPostUC;
  final UpdatePostUC updatePostUC;
  final DeletePostUC deletePostUC;

  AddDeleteUpdateBloc(
      {required this.addPostUC,
      required this.updatePostUC,
      required this.deletePostUC})
      : super(InitialAddDeleteUpdateState()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureORsuccess = await addPostUC(event.post);
        emit(_successOrErrorMessage(
            failureORsuccess, SuccessMessages.addPostSuccessMessage));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureORsuccess = await updatePostUC(event.post);
        emit(_successOrErrorMessage(
            failureORsuccess, SuccessMessages.updatePostSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureORsuccess = await deletePostUC(event.postId);
        emit(_successOrErrorMessage(
            failureORsuccess, SuccessMessages.deletePostSuccessMessage));
      }
    });
  }

  AddDeleteUpdateState _successOrErrorMessage(
      Either<Failure, Unit> failureORsuccess, String successMsg) {
    return failureORsuccess.fold(
        (failure) =>
            ErrorAddDeleteUpdateState(msgErr: _mapFailureToMessage(failure)),
        (_) => SuccessAddDeleteUpdateState(msgSuc: successMsg));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureMessages.serverFailureMessage;
      case OfflineFailure:
        return FailureMessages.offlineFailureMessage;
      default:
        return "Unexpected failure, Please try again later.";
    }
  }
}
