// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/posts_entity/like_entity/get_counter_like_entity.dart';
// ignore: unused_import
import '../../entities/posts_entity/post_entity/getall_post_entity.dart';
import '../../entities/posts_entity/comment_entity/getcomment_entity.dart';
import '../../entities/posts_entity/comment_entity/addcomment_entity.dart';
import '../../entities/posts_entity/like_entity/addlike_entity.dart';
import '../../entities/posts_entity/report_entity/addreport_entity.dart';
import '../../entities/posts_entity/post_entity/craetepost_entity.dart';
import '../../entities/posts_entity/comment_entity/deletecomment_entity.dart';
import '../../entities/posts_entity/like_entity/deletelike_entity.dart';
import '../../entities/posts_entity/post_entity/deletepost_entity.dart';
import '../../entities/posts_entity/comment_entity/updatecomment_entity.dart';
import '../../entities/posts_entity/post_entity/updatepost_entity.dart';

abstract class PostsRepository {
//Post//////
  Future<Either<Failure, ReportPostsEntity>> createpostrep(
      AddPostEntity datapost);
  Future<Either<Failure, ReportUpdatepostEntity>> updatepostrep(
      AddPostEntity datapost);
  // Future<Either<Failure, ReportGetAllPostsEntity>> getallposts();
  Future<Either<Failure, DeletepostEntity>> deletePost(
      DeleteIDpostEntity idpost);
//Like//////
  Future<Either<Failure, ReportAddLikeEntity>> addlike(PostID_Entity postId);
  Future<Either<Failure, GetCounterLikeEntity>> getlike(PostID_Entity postId);
  Future<Either<Failure, GetCounterLikeEntity>> getMylike(PostID_Entity postId);

  Future<Either<Failure, DeletelikeEntity>> deletelike(
      DeleteLikeIdPostEntity idpost);
//Comment///////
  Future<Either<Failure, ReportAddcommentEntity>> addcomment(
      AddcommentEntity comment);
  Future<Either<Failure, ReportGetCommentEntity>> getcomment(
      CommentPostIDEntity postId);
  Future<Either<Failure, ReportDeleteCommentEntity>> deletecomment(
      DeleteIDCommentEntity IDComment);
  Future<Either<Failure, ReportMessageUpdateCommentEntity>> updatecomment(
      UpdatecommentEntity updateComment);
//Report//////
  Future<Either<Failure, GetReportEntity>> addreport(AddReportEntity report);
}
