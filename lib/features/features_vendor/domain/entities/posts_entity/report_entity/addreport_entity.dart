import 'package:equatable/equatable.dart';

class AddReportEntity extends Equatable{
    AddReportEntity({
        required this.reason,
        required this.shopperId,
        required this.postId,
    });

    final String? reason;
    final String? shopperId;
    final String? postId;
    
      @override
      List<Object?> get props => [reason,shopperId,postId];

}
class GetReportEntity extends Equatable{
    GetReportEntity({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final DataReportEntity? data;
    
      @override
      // TODO: implement props
      List<Object?> get props => [success,message,data];


}

class DataReportEntity extends Equatable{
    DataReportEntity({
        required this.reason,
        required this.createdAt,
    });

    final String? reason;
    final DateTime? createdAt;
    
      @override
      // TODO: implement props
      List<Object?> get props => [reason,createdAt];

  

}
