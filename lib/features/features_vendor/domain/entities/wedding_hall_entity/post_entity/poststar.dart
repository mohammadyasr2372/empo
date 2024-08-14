import 'package:equatable/equatable.dart';

class PostStarEntity extends Equatable {
  PostStarEntity({
    required this.starId,
    required this.star,
  });

  final String? starId;
  final String? star;

  @override
  List<Object?> get props => [starId, star];
}

class ReportStar extends Equatable {
  ReportStar({
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;

  @override
  List<Object?> get props => [success,message];
}
