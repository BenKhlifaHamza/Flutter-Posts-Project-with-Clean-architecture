import 'package:equatable/equatable.dart';

class PostEntitie extends Equatable {
  final int? id;
  final String title;
  final String body;

  const PostEntitie(
      {required this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}
