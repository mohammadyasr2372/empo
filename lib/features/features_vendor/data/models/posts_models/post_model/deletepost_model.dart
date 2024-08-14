import '../../../../domain/entities/posts_entity/post_entity/deletepost_entity.dart';

class DeletepostModel extends DeletepostEntity {
  DeletepostModel({
    required this.success,
    required this.message,
  }) : super(success: success, message: message);

  final String? success;
  final String? message;

  factory DeletepostModel.fromJson(Map<String, dynamic> json) {
    return DeletepostModel(
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
  DeletepostEntity toEntity() {
    return DeletepostEntity(
      success: success,
      message: message,
    );
  }
}

class DeleteIDpostModel extends DeleteIDpostEntity {
  DeleteIDpostModel({
    required this.Idpost,
  }) : super(Idpost: Idpost);

  @override
  final String? Idpost;

  factory DeleteIDpostModel.fromJson(Map<String, dynamic> json) {
    return DeleteIDpostModel(
      Idpost: json["Idpost"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Idpost": Idpost,
      };
}
