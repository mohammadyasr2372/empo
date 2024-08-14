import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/wedding_hall_entity/get_entity/averagestar_entity.dart';
import '../../domain/entities/wedding_hall_entity/post_entity/poststar.dart';

class InformationSection extends StatelessWidget {
  const InformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final idStarEntity = IdStarEntity(starId: '6693b0411f6523ff15b16c2f');
    // context
    //     .read<WeddingBloc>()
    // .add(GetAverageStarWeddingEvent(idStar: idStarEntity));

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () async {
              // context
              //       .read<WeddingBloc>()
              //       .add(GetAverageStarWeddingEvent(idStar: idStarEntity))  ;
            },
            child: Center(child: CircularProgressIndicator())));
  }

  Widget _buildRatingSection(
      BuildContext context, averageStarsEntity? averageStar) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 9),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Vendor Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                RatingBar.builder(
                    tapOnlyMode: true,
                    updateOnDrag: true,
                    initialRating: averageStar?.avagerStars ?? 0.0,
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      if (averageStar != null) {
                        final postStarEntity = PostStarEntity(
                          starId: '6693b0411f6523ff15b16c2f',
                          star: rating.toString(),
                        );
                        // context.read<WeddingBloc>().add(
                        //     PostStarWeddingEvent(poststar: postStarEntity));
                      }
                    }),
                const SizedBox(width: 5),
                if (averageStar != null) ...[
                  Text(
                    '${averageStar.avagerStars!.toStringAsFixed(1)} ( Reviews)',
                    style: const TextStyle(fontSize: 16),
                  ),
                ] else ...[
                  const SizedBox.shrink(),
                ],
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Share.share("Check out this awesome package!!!");
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.share),
                  ),
                ),
                const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.location_on),
                ),
                const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.bookmark_border),
                ),
                const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.favorite_border_sharp),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:dio/dio.dart';

// class StarsHall extends StatefulWidget {
//   final String name;
//   final String customerId;
//   final String authToken;

//   const StarsHall(
//       {Key? key,
//       required this.name,
//       required this.customerId,
//       required this.authToken})
//       : super(key: key);

//   @override
//   _StarsHallState createState() => _StarsHallState();
// }

// class _StarsHallState extends State<StarsHall> {
//   double? averageStars;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     fetchAverageStars(starId: widget.customerId);
//   }

//   Future<void> fetchAverageStars({required String starId}) async {
//     Dio dio = Dio();
//     try {
//       Response response = await dio.put(
//         'http://10.0.2.2:3000/api/avager_stars_widding',
//         data: {
//           'starId': starId,
//         },
//         options: Options(
//           headers: {
//             'token': widget.authToken,
//           },
//         ),
//       );
//       avager_Stars avgStars = avager_Stars.fromJson(response.data);
//       if (avgStars.success!) {
//         setState(() {
//           averageStars = avgStars.avagerStars;
//         });
//       } else {
//         setState(() {
//           errorMessage = avgStars.message;
//         });
//       }
    // } on DioError catch (e) {

    //     if (e.response?.statusCode == 401) {
    //       errorMessage = 'Authentication error: ${e.response?.statusMessage}';
    //     } else {
    //       errorMessage = 'Error occurred: ${e.response?.data ?? e.message}';
    //     }

//     } catch (e) {
//       setState(() {
//         errorMessage = 'Unexpected error: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 9),
//         Align(
//           alignment: Alignment.topLeft,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(
//               widget.name,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Row(
//             children: [
//               RatingBar.builder(
//                 initialRating: averageStars ?? 0,
//                 minRating: 0.5,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
//                 itemBuilder: (context, _) => const Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),
//                 onRatingUpdate: (rating) {
//                   print('rating $rating');
//                 },
//               ),
//               const SizedBox(width: 5),
//               Text(' 4.5 (200 Reviews)',
//                 // averageStars != null
//                 //     ? '${averageStars!.toStringAsFixed(1)} (200 Reviews)'
//                 //     : 'Loading...',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         if (errorMessage != null)
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(
//               errorMessage!,
//               style: const TextStyle(color: Colors.red, fontSize: 16),
//             ),
//           ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Share.share("Check out this awesome package!!!");
//                 },
//                 child: const CircleAvatar(
//                   radius: 25,
//                   child: Icon(Icons.share),
//                 ),
//               ),
//               const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.location_on),
//               ),
//               const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.bookmark_border),
//               ),
//               const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.favorite_border_sharp),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:dio/dio.dart';

// class InformationSection extends StatelessWidget {

//   InformationSection(
//       {Key? key,
//       })
//       : super(key: key);

//   // Future<void> submitRating(double rating) async {
//   //   Dio dio = Dio();
//   //   try {
//   //     PostStar postStar = PostStar(starId: customerId, star: rating.toString());
//   //     Response response = await dio.post(
//   //       'http://10.0.2.2:3000/api/give_star_widding',
//   //       data: postStar.toMap(),
//   //       options: Options(
//   //         headers: {
//   //           'token': ' $authToken',
//   //         },
//   //       ),
//   //     );
//   //     ReportStar reportStar = ReportStar.fromJson(response.data);
//   //     if (reportStar.success!) {
//   //       print('Rating submitted successfully: ${reportStar.message}');
//   //     } else {
//   //       print('Failed to submit rating: ${reportStar.message}');
//   //     }
//   //   } catch (e) {
//   //     print('Error occurred while submitting rating: $e');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 9),
//         Align(
//           alignment: Alignment.topLeft,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(
//               'name',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Row(
//             children: [
//               RatingBar.builder(
//                 initialRating: 0,
//                 minRating: 1.5,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
//                 itemBuilder: (context, _) => const Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),
//                 onRatingUpdate: (rating) {
//                   print('rating $rating');
//                 },
//               ),
//               const SizedBox(width: 5),
//               const Text('4.5 (200 Reviews)', style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Share.share("Check out this awesome package!!!");
//                 },
//                 child: const CircleAvatar(
//                   radius: 25,
//                   child: Icon(Icons.share),
//                 ),
//               ),
//               const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.location_on),
//               ),
//               const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.bookmark_border),
//               ),
//               // const CircleAvatar(
//               //   radius: 25,
//               //   child: Icon(Icons.favorite_border_sharp),
//               // ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
