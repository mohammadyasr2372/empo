import 'package:equatable/equatable.dart';

class averageStarsEntity extends Equatable {
  averageStarsEntity({
    required this.success,
    required this.message,
    required this.avagerStars,
  });

  final bool? success;
  final String? message;
  final double? avagerStars;

  @override
  List<Object?> get props => [success, message, avagerStars];
}

class IdStarEntity extends Equatable {
  IdStarEntity({
    required this.starId,
  });

  final String? starId;

  @override
  List<Object?> get props => [starId];
}
