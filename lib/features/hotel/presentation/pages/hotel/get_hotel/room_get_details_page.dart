// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:party/features/hotel/presentation/widgets/BookingButton.dart';

import '../../../../../../core/strings/constans.dart';
import '../../../../../../injection_container.dart' as di;
import '../../../../data/model/add_booked_room.dart';
import '../../../bloc/get_room/get_room_bloc.dart';

class RoomGetDetailsPage extends StatefulWidget {
  final String id;

  const RoomGetDetailsPage({super.key, required this.id});
  @override
  _RoomGetDetailsPageState createState() => _RoomGetDetailsPageState();
}

class _RoomGetDetailsPageState extends State<RoomGetDetailsPage> {
  TextEditingController numberGuestController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  int _numPeople = 1;
  int _numNights = 0;
  void _calculateNumNights() {
    if (_startDate != null && _endDate != null) {
      setState(() {
        _numNights = _endDate!.difference(_startDate!).inDays;
      });
    }
  }

  String get _formattedStartDate {
    return '${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}';
  }

  String get _formattedEndDate {
    return '${_endDate!.year}-${_endDate!.month.toString().padLeft(2, '0')}-${_endDate!.day.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 7));
    _calculateNumNights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoomGet Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) =>
              di.sl<GetRoomBloc>()..add(GetInfoHotelEvent(idRoom: widget.id)),
          child: BlocConsumer<GetRoomBloc, GetRoomState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadedProGetRoomState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.roomGet.image_room.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                BASE_URL +
                                    '/' +
                                    state.roomGet.image_room[index].url
                                        .split('/')
                                        .last,
                                height: 250.0,
                                width: 300.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'RoomGet Type: ${state.roomGet.room_type}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Price per Night: ${state.roomGet.price_day.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Date Range'),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () async {
                        final dateRange = await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(
                            start: _startDate!,
                            end: _endDate!,
                          ),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (dateRange != null) {
                          setState(() {
                            _startDate = dateRange.start;
                            _endDate = dateRange.end;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Text(DateFormat('MMM d, yyyy').format(_startDate!)),
                          const Text(' - '),
                          Text(DateFormat('MMM d, yyyy').format(_endDate!)),
                          const Spacer(),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Number of People'),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: numberGuestController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _numPeople = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                    Text(
                      'Number of Nights: $_numNights',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'price totals: ${_numNights * state.roomGet.price_day}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    BookingButton(
                      onPressed: () {
                        print(AddBookedRoom(
                            idRoom: widget.id,
                            number_guest: numberGuestController.text,
                            data_stay: _formattedStartDate,
                            data_leave: _formattedEndDate));
                      },
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(state.toString()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
