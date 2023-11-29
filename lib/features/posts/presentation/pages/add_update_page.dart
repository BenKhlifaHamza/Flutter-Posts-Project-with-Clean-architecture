import '../../../../core/routes/routes_names.dart';
import '../../domaine/entities/post_entitie.dart';
import '../blocs/add_delete_update_post/add_delete_update_bloc.dart';
import '../widgets/add_update_widgets/add_update_form.dart';
import '../widgets/shared_widgets/loading_widgets.dart';
import '../widgets/shared_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdatePage extends StatelessWidget {
  final PostEntitie? postEntitie;
  final bool isUpdate;
  const AddUpdatePage({super.key, this.postEntitie, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(isUpdate ? "Update Post" : "Add Post"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
          builder: (context, state) {
        if (state is LoadingAddDeleteUpdateState) {
          return const LoadingWidget();
        } else {
          return AddUpdateForm(isUpdate: isUpdate, postEntitie: postEntitie);
        }
      }, listener: (context, state) {
        if (state is SuccessAddDeleteUpdateState) {
          SnackBarWidget.showSuccessSnackBar(
            context: context,
            msgSuc: state.msgSuc,
          );
          Navigator.of(context)
              .pushNamedAndRemoveUntil(RoutesNames.postPage, (route) => false);
        } else if (state is ErrorAddDeleteUpdateState) {
          SnackBarWidget.showErrorSnackBar(
              msgErr: state.msgErr, context: context);
        }
      }),
    );
  }
}
