import '../../../domaine/entities/post_entitie.dart';
import '../../blocs/add_delete_update_post/add_delete_update_bloc.dart';
import 'submit_button_widget.dart';
import 'text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateForm extends StatefulWidget {
  final bool isUpdate;
  final PostEntitie? postEntitie;
  const AddUpdateForm(
      {super.key, required this.isUpdate, required this.postEntitie});

  @override
  State<AddUpdateForm> createState() => _AddUpdateFormState();
}

class _AddUpdateFormState extends State<AddUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void addOrUpdate() {
    final isValide = _formKey.currentState!.validate();
    if (isValide) {
      final post = PostEntitie(
          id: widget.isUpdate ? widget.postEntitie!.id : 0,
          title: _titleController.text,
          body: _bodyController.text);
      if (widget.isUpdate) {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleController.text = widget.postEntitie!.title;
      _bodyController.text = widget.postEntitie!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiLines: true, controller: _bodyController),
            SubmitButtonWidget(
                onPressed: () => addOrUpdate(), isUpdate: widget.isUpdate)
          ],
        ));
  }
}
