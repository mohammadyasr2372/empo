// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously, unused_element

// import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:party/core/strings/constans.dart';
import 'package:party/features/auth/data/data_sources/remote/shopper_api_service.dart';
import 'package:party/features/auth/data/model/post_info_shoppper.dart';
import 'package:party/features/auth/presentation/pages/create_wallet.dart';
import 'package:party/features/auth/presentation/widgets/button.dart';
// import 'package:party/features/hotel/data/data_sources/remote/widd_api_service.dart';
import 'package:party/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features_vendor/presentation/pages/wedding_hall/post_wedding_hall/Wedding_Hall_Post.dart';
import '../../../hotel/presentation/pages/hotel/post_hotel/hotel_post.dart';

TextEditingController? nameEventcontroller = TextEditingController();
final ImagePicker _picker = ImagePicker();
File? imageShop;
double? latitude;
double? longitude;
String? addressName;
String? city;
String? country;

class AddInfoShopper extends StatefulWidget {
  String title = 'avsx ';

  AddInfoShopper({super.key});

  @override
  State<AddInfoShopper> createState() => _AddInfoShopperState();
}

class _AddInfoShopperState extends State<AddInfoShopper> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        // appBar: AppBar(
        //   // Here we take the value from the AddInfoShopper object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text(widget.title),
        // ),
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _imageFile == null
              ? CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                )
              : CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(_imageFile!),
                ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.camera_alt),
            label: Text('Selected image'),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: width - 35,
            child: TextField(
              controller: nameEventcontroller,
              decoration: InputDecoration(
                hintText: 'Name Shop ',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 3.0),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          LocationInfoWidget(
              country: country ?? '',
              city: city ?? '',
              longitude: longitude.toString(),
              latitude: latitude.toString()),
          SizedBox(
            height: 20,
          ),
          ButtonAuth(
              title: 'Add Location',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => OpenStreet(
                              title: 'as',
                            )),
                    (route) => false);
              },
              width: width),
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ButtonAuth(
                  title: 'Save',
                  onPressed: () async {
                    await sl<ShopperApiService>().AddInfoShopper(
                      postInfoLocationShopper: PostInfoLocationShopper(
                          location1: latitude ?? 0,
                          location2: longitude ?? 0,
                          Name: nameEventcontroller!.text,
                          city: city ?? 'dammascus',
                          image: _imageFile!),
                    );
                    String temp = sl
                        .get<SharedPreferences>()
                        .getString(CACHED_TYPE_SHOPPER)!;
                    print(temp);
                    if (temp == 'Wedding Hall') {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => WeddingHallPost()));
                    } else if (temp == 'Hotal') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => /*CreateWallet*/ PostHotel()));
                    } else if (temp == 'Cadies shop') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => /*CreateWallet*/ PostHotel()));
                    } else if (temp == 'Restorant') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => /*CreateWallet*/ PostHotel()));
                    }
                  },
                  width: width)),
        ],
      ),
    ));
  }
}

class OpenStreet extends StatefulWidget {
  const OpenStreet({super.key, required this.title});

  final String title;

  @override
  State<OpenStreet> createState() => _OpenStreetState();
}

class _OpenStreetState extends State<OpenStreet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: height - 20,
          width: double.maxFinite,
          child: OpenStreetMapSearchAndPick(
            buttonTextStyle:
                const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              latitude = pickedData.latLong.latitude;
              longitude = pickedData.latLong.longitude;
              country = pickedData.address['country'];
              city = pickedData.address['state'];

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddInfoShopper()));
            },
          ),
        ),
      ],
    ));
  }
}

class LocationInfoWidget extends StatelessWidget {
  final String country;
  final String city;
  final String longitude;
  final String latitude;

  const LocationInfoWidget({
    super.key,
    required this.country,
    required this.city,
    required this.longitude,
    required this.latitude,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Country: $country',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'City: $city',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Longitude: $longitude',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Latitude: $latitude',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
