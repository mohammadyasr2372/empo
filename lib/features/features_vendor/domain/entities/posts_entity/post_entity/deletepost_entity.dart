import 'package:equatable/equatable.dart';

class DeletepostEntity extends Equatable {
  DeletepostEntity({
    required this.success,
    required this.message,
  });

  final String? success;
  final String? message;

  @override
  List<Object?> get props => [success, message];
}

class DeleteIDpostEntity extends Equatable {
  DeleteIDpostEntity({
    required this.Idpost,
  });

  final String? Idpost;

  @override
  List<Object?> get props => throw UnimplementedError();
}
