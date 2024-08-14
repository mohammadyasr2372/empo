import 'package:equatable/equatable.dart';

class entity_add_image_hospit extends Equatable {
  entity_add_image_hospit({
    required this.success,
    required this.msg,
    required this.imagehospit,
  });

  final bool? success;
  final String? msg;
  final List<Entity_Imagehospit> imagehospit;

  @override
  List<Object?> get props => [success, msg, imagehospit];
}

class Entity_Imagehospit extends Equatable {
  Entity_Imagehospit({
    required this.id,
  });

  final String? id;

  @override
  List<Object?> get props => [id];
}
