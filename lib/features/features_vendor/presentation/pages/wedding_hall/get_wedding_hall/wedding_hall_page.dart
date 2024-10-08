import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/data_source/wedding_data_source/weddingHallDataSource.dart';
import '../../../../data/models/wedding_hall_model/get/report_get.dart';
import '../../../widgets/BookingButton.dart';
import '../../../widgets/ImagePlaceholder.dart';
import '../../Stars_hall.dart';
import '../../Users/booked/BookedUser/booked_weddinghall.dart';
import 'Hospitality_Images_Section.dart';

class WeddingHallPage extends StatefulWidget {
  WeddingHallPage({Key? key}) : super(key: key);

  @override
  State<WeddingHallPage> createState() => _WeddingHallPageState();
}

class _WeddingHallPageState extends State<WeddingHallPage> {
  bool isLoading = true;
  String? errorMessage;
  WeddinghalldatasourceImpl Weddinghalldatasource =
      WeddinghalldatasourceImpl(dio: Dio());
  msg_Get_Wedd_hal? msg_GetWedding;

  @override
  void initState() {
    super.initState();
    fetchWeddingDetails();
  }

  Future<void> fetchWeddingDetails() async {
    try {
      final getinfo =
          await Weddinghalldatasource.getweddingdetailsdatasourece();
      setState(() {
        msg_GetWedding = getinfo;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching wedding details: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImagesSectionWedding(data: msg_GetWedding!.dataWidding!),
            // InformationSection(),
            HospitalityImagesSection(
              imagePaths: msg_GetWedding!.dataWidding!.imagehospit
                  .map((image) => image.url!)
                  .toList(),
              bookingPrice: msg_GetWedding!.dataWidding!.bookprice,
              pricePerPerson: msg_GetWedding!.dataWidding!.personbook,
              maxCapacity: msg_GetWedding!.dataWidding!.capacity,
              minPersons: msg_GetWedding!.dataWidding!.capacityMin,
            ),
            BookingButton(onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyAppp1()),
              // );
            }),
          ],
        ),
      ),
    );
  }
}

class ImagesSectionWedding extends StatefulWidget {
  final DataWidding data;

  const ImagesSectionWedding({Key? key, required this.data}) : super(key: key);

  @override
  _ImagesSectionWeddingState createState() => _ImagesSectionWeddingState();
}

class _ImagesSectionWeddingState extends State<ImagesSectionWedding> {
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pages = widget.data.imagewids
        .map((image) => ImagePlaceholderWedding(imagePath: image.url!))
        .toList();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_pageController.page == _pages.length - 1) {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3.4,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (value) {
              setState(() {
                _activePage = value;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                _pages.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: _activePage == index
                          ? Colors.deepPurple
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../domain/entities/wedding_hall_entity/get_entity/getwedding.dart';
// import '../../../bloc/wedding_hall_bloc/wedding_bloc.dart';
// import '../../../widgets/BookingButton.dart';
// import '../../Hall_Images_Section.dart';
// import '../../Stars_hall.dart';
// import 'Hospitality_Images_Section.dart';

// class WeddingHallPage extends StatelessWidget {
//   WeddingHallPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WeddingBloc, WeddingState>(
//       builder: (context, state) {
//         if (state is LoadedWeddingState) {
//           final weddingHall = state.getweddEntity;
//           return Scaffold(
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ImagesSection(
//                       imagePaths: getImagePaths(weddingHall.dataWidding)),
//                       InformationSection(),
//                   // StarsHall(
//                   //   name: weddingHall.dataWidding!.id ??
//                   //       '', // Adjust this based on your requirements
//                   //   customerId: '665efefe9b89ab3f4a632ad0',
//                   //   authToken:
//                   //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NWVmZjQ0OWI4OWFiM2Y0YTYzMmFkOCIsImlzX3VzZXIiOnRydWUsImlhdCI6MTcxNzUwMTc2NCwiZXhwIjoxNzE3NTA4OTY0fQ.LKljxc00fUV86HB85xw6x3z4DI1PjrKTBzxBnWwLXuw',
//                   // ),
//                   HospitalityImagesSection(
//                     imagePaths: weddingHall.dataWidding!.imagehospit
//                         .map((image) => image.toString())
//                         .toList(),
//                     bookingPrice: weddingHall.dataWidding!.bookprice,
//                     pricePerPerson: weddingHall.dataWidding!.personbook,
//                     maxCapacity: weddingHall.dataWidding!.pricetotel,
//                     minPersons: weddingHall.dataWidding!
//                         .capacityMin, // Assuming imagehospit is List<dynamic>
//                   ),
//                   BookingButton(onPressed: () {
//                     // Implement navigation to booking page
//                   }),
//                 ],
//               ),
//             ),
//           );
//         } else if (state is ErrorWeddingState) {
//           return Center(
//               child:
//                   Text('Failed to load wedding hall data: ${state.message}'));
//         }

//         return Container();
//       },
//     );
//   }

//   List<String> getImagePaths(GetDataWiddingEntity? dataWidding) {
//     if (dataWidding != null && dataWidding.imagewids.isNotEmpty) {
//       return dataWidding.imagewids.map((image) => image.id ?? '').toList();
//     } else {
//       return [];
//     }
//   }
// }
