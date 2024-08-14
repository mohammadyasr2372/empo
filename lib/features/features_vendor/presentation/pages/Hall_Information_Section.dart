// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:share_plus/share_plus.dart';

// import '../../../core/network/network_info.dart';
// import '../../data/data_source/wedding_data_source/weddingHallDataSource.dart';
// import '../../data/repositoryImp/wedding_repository_imp/wedding_repository_imp.dart';
// import '../../domain/entities/wedding_hall_entity/post_entity/poststar.dart';
// import '../../domain/repository/wedding_hall_repositories/wedding_hall_repository.dart';
// import '../../domain/use_cases/wedding_hall_usecase/add_image_hopit_usecase.dart';
// import '../../domain/use_cases/wedding_hall_usecase/create_wedding.dart';
// import '../../domain/use_cases/wedding_hall_usecase/getAveragestar_usecase.dart';
// import '../../domain/use_cases/wedding_hall_usecase/get_wegging.dart';
// import '../../domain/use_cases/wedding_hall_usecase/post_star_usecase.dart';
// import '../../domain/use_cases/wedding_hall_usecase/update_wedding_usecase.dart';
// import '../bloc/wedding_hall_bloc/wedding_bloc.dart';

// class InformationSection3 extends StatelessWidget {
//   InformationSection3({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final NetworkInfo networkInfo =
//         NetworkInfoImpl(InternetConnectionChecker());
//     final WeddingHallRepository weddingHallRepository =
//         WeddingHallRepositoryImpl(
//       Wedding_hall_datasource: WeddinghalldatasourceImpl(dio: Dio()),
//       networkInfo: networkInfo,
//     );
//     return BlocProvider(
//       create: (context) => WeddingBloc(
//         addImageHopitUsecase: AddImageHopitUsecase(weddingHallRepository),
//         createWeddingDetails: CreateWeddingDetails(weddingHallRepository),
//         getWeddingHall: GetWeddingHall(weddingHallRepository),
//         UpdateWedding: UpdateWeddingUsecase(weddingHallRepository),
//         averagestarsWedding:
//             GetAverageStarsWeddingHall(weddingHallRepository),
//         poststarsUsecase: PostStarsUsecase(weddingHallRepository),
//       ),
//       child: BlocConsumer<WeddingBloc, WeddingState>(
//         listener: (context, state) {
//           if (state is SuccessWeddingState) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           } else if (state is ErrorWeddingState) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         builder: (context, state) {
//           if (state is loadingWeddingState) {
//             return Center(child: CircularProgressIndicator());
//           } else
//            if (state is LoadedStarsWeddingState) {
//             return Scaffold(
//               body: Column(
//                 children: [
//                   const SizedBox(height: 9),
//                   _TitleSection(),
//                   const SizedBox(height: 5),
//                   _RatingSection(
//                     averageStar: state.averageStar.avagerStars!,
//                     numberOfReviews: state.averageStar.avagerStars!,
//                     onRatingUpdate: (rating) {
//                       final postStarEntity = PostStarEntity(
//                         star: rating.toString(),
//                         starId: '6683d6de40de3a6149dd7180',
//                       );
//                       context.read<WeddingBloc>().add(PostStarWeddingEvent(
//                             poststar: postStarEntity,
//                           ));
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   _ActionIcons(),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             );
//           } else {
//             // Default state or Error handling
//             return Scaffold(
//               body: Column(
//                 children: [
//                   const SizedBox(height: 9),
//                   _TitleSection(),
//                   const SizedBox(height: 5),
//                   _RatingSection(averageStar: 0, numberOfReviews: 0, onRatingUpdate: (double value) {  },),
//                   const SizedBox(height: 10),
//                   _ActionIcons(),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class _TitleSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Text(
//           'name',
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

// class _RatingSection extends StatelessWidget {
//   final double averageStar;
//   final double numberOfReviews;
//   final ValueChanged<double> onRatingUpdate;

//   _RatingSection({
//     required this.averageStar,
//     required this.numberOfReviews,
//     required this.onRatingUpdate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Row(
//         children: [
//           RatingBar.builder(
//             initialRating: averageStar,
//             minRating: 1.5,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemCount: 5,
//             itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
//             itemBuilder: (context, _) => const Icon(
//               Icons.star,
//               color: Colors.amber,
//             ),
//             onRatingUpdate: onRatingUpdate,
//           ),
//           const SizedBox(width: 5),
//           Text('$averageStar ($numberOfReviews Reviews)',
//               style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }

// class _ActionIcons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: () {
//               Share.share("Check out this awesome package!!!");
//             },
//             child: const CircleAvatar(
//               radius: 25,
//               child: Icon(Icons.share),
//             ),
//           ),
//           const CircleAvatar(
//             radius: 25,
//             child: Icon(Icons.location_on),
//           ),
//           const CircleAvatar(
//             radius: 25,
//             child: Icon(Icons.bookmark_border),
//           ),
//           const CircleAvatar(
//             radius: 25,
//             child: Icon(Icons.favorite_border_sharp),
//           ),
//         ],
//       ),
//     );
//   }
// }
