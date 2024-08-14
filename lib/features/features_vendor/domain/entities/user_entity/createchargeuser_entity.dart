import 'package:equatable/equatable.dart';

class CreatechargeuserEntity extends Equatable {
  CreatechargeuserEntity({
    required this.password,
    required this.rechargeMoney,
    required this.walteId,
  });

  final String? password;
  final String? rechargeMoney;
  final String? walteId;

  @override
  List<Object?> get props => [password, rechargeMoney, walteId];
}
