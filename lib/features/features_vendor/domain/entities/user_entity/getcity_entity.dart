import 'package:equatable/equatable.dart';

class GetcityEntity extends Equatable {
  GetcityEntity({
    required this.success,
    required this.city,
  });

  final bool? success;
  final List<String> city;

  @override
  // TODO: implement props
  List<Object?> get props => [
        success,
        city,
      ];
}
