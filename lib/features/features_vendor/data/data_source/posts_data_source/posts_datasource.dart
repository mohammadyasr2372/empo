// ignore_for_file: public_member_/api_docs, sort_constructors_first, non_constant_identifier_names, constant_identifier_names, avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:party/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../../../injection_container.dart' as di;
import '../../../domain/entities/posts_entity/post_entity/craetepost_entity.dart';
import '../../models/posts_models/comment_model/deletecomment_model.dart';
import '../../models/posts_models/comment_model/getcomment_model.dart';
import '../../models/posts_models/like_model/deletelike_model.dart';
import '../../models/posts_models/like_model/get_counter_like_modle.dart';
import '../../models/posts_models/post_model/deletepost_model.dart';
import '../../models/posts_models/post_model/getall_post_model.dart';
import '../../models/posts_models/comment_model/addcomment_model.dart';
import '../../models/posts_models/like_model/addlike_model.dart';
import '../../models/posts_models/report_model/addreport_model.dart';
import '../../models/posts_models/post_model/createpost_model.dart';
import '../../models/posts_models/comment_model/updatecomment_model.dart';
import '../../models/posts_models/post_model/updatepost_model.dart';

abstract class PostsDatasource {
////////////posts//////////////
  Future<Unit> createpost_datasource(AddPostEntity addPostEntity);
  Future<ReportUpdatepostModel> updatepost_datasource(AddPostEntity datapost);
  Future<ReportGetAllPostsModle> getallposts_datasource();
  Future<DeletepostModel> deletePost_datasource(DeleteIDpostModel idpost);
///////////Comment/////////////
  Future<ReportAddcommentModel> addcomment_datasource(AddcommentModel comment);
  Future<ReportGetCommentModel> getcomment_datasource(
      CommentPostIDModel postID);
  Future<ReportMessageUpdateCommentModel> updatecomment_datasource(
      UpdatecommentModel IDComment);
  Future<ReportDeleteCommentModel> deletecomment_datasource(
      DeleteIDCommentModel IDComment);
////////////Like///////////////
  Future<ReportAddLikeModel> addlike_datasource(PostID_Model postId);
  Future<GetCounterLikeModle> getlike_datasource(PostID_Model postId);
  Future<DeletelikeModel> deletelike_datasource(DeleteLikeIdPostModel postId);
  Future<GetCounterLikeModle> getMylike_datasource(PostID_Model postId);
/////////////Report/////////
  Future<GetReportModel> addreport_datasource(AddReportModel report);
}

class PostdatasourceImpl implements PostsDatasource {
  final Dio dio;
  PostdatasourceImpl({
    required this.dio,
  });
////////////////////////Posts///////////////////
  @override
  Future<Unit> createpost_datasource(AddPostEntity addPostEntity) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/create_post'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in addPostEntity.images) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        imagePath.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }

    request.fields.addAll({
      'title': addPostEntity.title!,
      'content': addPostEntity.content!,
      'shopperId': di.sl.get<SharedPreferences>().getString(CACHED_ID_SHOOPER)!,
    });

    final response = await request.send();
    if (response.statusCode == 200) {
      print('File upload successful ');
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      print(data);
    } else {
      print('File upload failed with status code: ${response.statusCode}');
      print(
          'File upload failed with status code: ${await response.stream.bytesToString()}');
    }
    return Future.value(unit);
  }

  @override
  Future<ReportUpdatepostModel> updatepost_datasource(
      AddPostEntity datapost) async {
    FormData formData = FormData.fromMap({
      // 'shopperId': datapost.shopperId,
      'content': datapost.content,
      'title': datapost.title,
      // 'images': datapost.images
      //     .map((file) => MultipartFile.fromFileSync(file.images!.path))
      //     .toList(),
    });
    try {
      final response = await dio.post(
        '${BASE_URL}/api/shopper/updata_post',
        data: formData,
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 201) {
        ReportUpdatepostModel rUpdatepost =
            ReportUpdatepostModel.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${rUpdatepost.success}');
        return rUpdatepost;
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  @override
  Future<ReportGetAllPostsModle> getallposts_datasource() async {
    print(di.sl.get<SharedPreferences>().getString(CACHED_Token)!);
    print('${BASE_URL}/api/getall_posts');
    try {
      final response = await dio.get(
        '${BASE_URL}/api/getall_posts',
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        // final decodedJson = jsonDecode(response.data);
        final msgGetWeddhal = ReportGetAllPostsModle.fromJson(response.data);
        return msgGetWeddhal;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  @override
  Future<DeletepostModel> deletePost_datasource(
      DeleteIDpostModel idpost) async {
    try {
      DeleteIDpostModel IDPOST = DeleteIDpostModel(Idpost: idpost.Idpost);
      final response = await dio.delete(
        '${BASE_URL}/api/shopper/deleteMypost/$IDPOST',
        // data: deletecomment.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final deletePost = DeletepostModel.fromJson(decodedJson);
        return deletePost;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
    }
    throw ServerException();
  }

/////////////////////////////////Comment////////////////////////
  @override
  Future<ReportAddcommentModel> addcomment_datasource(
      AddcommentModel comment) async {
    AddcommentModel addcomment = AddcommentModel(
        contentComment: comment.contentComment, postId: comment.postId);
    try {
      final response = await dio.post(
        '${BASE_URL}/api/addComment',
        data: addcomment.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 201) {
        ReportAddcommentModel reportaddcomment =
            ReportAddcommentModel.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${reportaddcomment.success}');
        print('${reportaddcomment.message}');
        print('${reportaddcomment.data}');
        return reportaddcomment;
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  @override
  Future<ReportMessageUpdateCommentModel> updatecomment_datasource(
      UpdatecommentModel IDComment) async {
    try {
      UpdatecommentModel deletecomment = UpdatecommentModel(
          commentId: IDComment.commentId,
          contentComment: IDComment.contentComment);
      final response = await dio.put(
        '${BASE_URL}/api/upadateComment',
        data: deletecomment.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final updateComment =
            ReportMessageUpdateCommentModel.fromJson(decodedJson);
        return updateComment;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
    }
    throw ServerException();
  }

  @override
  Future<ReportGetCommentModel> getcomment_datasource(
      CommentPostIDModel postID) async {
    try {
      CommentPostIDModel commentPostId =
          CommentPostIDModel(postId: postID.postId);
      final response = await dio.get(
        '${BASE_URL}/api/postComments?postId=$commentPostId',
        queryParameters: commentPostId.toMap(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final msgGetWeddhal = ReportGetCommentModel.fromJson(decodedJson);
        return msgGetWeddhal;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
    }
    throw ServerException();
  }

  @override
  Future<ReportDeleteCommentModel> deletecomment_datasource(
      DeleteIDCommentModel IDComment) async {
    try {
      DeleteIDCommentModel deletecomment =
          DeleteIDCommentModel(commentId: IDComment.commentId);
      final response = await dio.delete(
        '${BASE_URL}/api/deleteComment',
        data: deletecomment.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final deleteComment = ReportDeleteCommentModel.fromJson(decodedJson);
        return deleteComment;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
    }
    throw ServerException();
  }

/////////////////////////////////Like///////////////////////
  @override
  Future<ReportAddLikeModel> addlike_datasource(PostID_Model postId) async {
    PostID_Model postID = PostID_Model(postId: postId.postId);
    try {
      final response = await dio.post(
        '${BASE_URL}/api/add_like',
        data: postID.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 201) {
        ReportAddLikeModel reportaddlike =
            ReportAddLikeModel.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${reportaddlike.success}');
        print('${reportaddlike.message}');
        return reportaddlike;
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  @override
  Future<GetCounterLikeModle> getlike_datasource(PostID_Model postId) async {
    PostID_Model postID = PostID_Model(postId: postId.postId);
    try {
      final response = await dio.post(
        '${BASE_URL}/api/get_conuter_like',
        data: postID.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 201) {
        GetCounterLikeModle reportaddlike =
            GetCounterLikeModle.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${reportaddlike.success}');
        return reportaddlike;
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  @override
  Future<GetCounterLikeModle> getMylike_datasource(PostID_Model postId) async {
    try {
      PostID_Model postID = PostID_Model(postId: postId.postId);

      final response = await dio.post(
        '${BASE_URL}/api/shopper/get_conuter_mylike',
        data: postID.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 201) {
        GetCounterLikeModle reportaddlike =
            GetCounterLikeModle.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${reportaddlike.success}');
        return reportaddlike;
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  @override
  Future<DeletelikeModel> deletelike_datasource(
      DeleteLikeIdPostModel postId) async {
    try {
      DeleteLikeIdPostModel IDPOST =
          DeleteLikeIdPostModel(postId: postId.postId);
      final response = await dio.delete(
        '${BASE_URL}/api/delete_like',
        data: IDPOST.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final deletePost = DeletelikeModel.fromJson(decodedJson);
        return deletePost;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
    }
    throw ServerException();
  }

///////////////////////////////Report//////////////////////////
  @override
  Future<GetReportModel> addreport_datasource(AddReportModel report) async {
    AddReportModel addreport = AddReportModel(
      postId: report.postId,
      reason: report.reason,
      shopperId: report.shopperId,
    );
    try {
      final response = await dio.post(
        '${BASE_URL}/api/addReport',
        data: addreport.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 201) {
        GetReportModel getreport = GetReportModel.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${getreport.success}');
        print('${getreport.message}');
        return getreport;
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  Uri _getUri(String url) {
    return Uri.parse(url);
  }
}
