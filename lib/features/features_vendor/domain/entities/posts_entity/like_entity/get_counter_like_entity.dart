import 'package:equatable/equatable.dart';

class GetCounterLikeEntity extends Equatable{
    GetCounterLikeEntity({
        required this.success,
        required this.counterLikes,
    });

    final bool? success;
    final int? counterLikes;
    
      @override
      // TODO: implement props
      List<Object?> get props => [success,counterLikes];

}
