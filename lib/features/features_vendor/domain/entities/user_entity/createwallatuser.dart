import 'package:equatable/equatable.dart';

class Createwallatuser extends Equatable {
    Createwallatuser({
        required this.password,
    });

    final String? password;

    
      @override
      List<Object?> get props => [password];

}
