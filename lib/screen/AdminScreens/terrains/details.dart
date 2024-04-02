import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/reserve.dart';

class TerrainDetailsScreen extends StatelessWidget {
  final TerrainModel terrainModel;
  const TerrainDetailsScreen({super.key, required this.terrainModel});

  @override
  Widget build(BuildContext context) {
    final terrainCubit = TerrainCubit.get(context);

    final CarouselController _controller = CarouselController();
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terrain Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<TerrainCubit, TerrainState>(
              builder: (context, state) {
                return carouselSliderWithIndicator(
                    _controller, screenHeight, terrainCubit);
              },
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            BlocBuilder<TerrainCubit, TerrainState>(
              builder: (context, state) {
                return togeleReserveOrShowDescription(terrainCubit, context);
              },
            ),
            BlocBuilder<TerrainCubit, TerrainState>(
              builder: (context, state) {
                if (terrainCubit.showStadiumDetails) {
                  return descriptionInfo(screenHeight, context);
                } else {
                  return reservationGrid(screenHeight, terrainCubit, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Column reservationGrid(
      double screenHeight, TerrainCubit terrainCubit, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.035,
        ),
        SizedBox(
          height: screenHeight * 0.08,
          child: SizedBox(
            height: screenHeight * 0.08,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0;
                    i < 7;
                    i++) // Display 7 days and allow user to select a date in the last index
                  GestureDetector(
                    onTap: () => terrainCubit
                        .selectDate(DateTime.now().add(Duration(days: i))),
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.center,
                        DateFormat('EEE, MMM d')
                            .format(DateTime.now().add(Duration(days: i))),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: terrainCubit.selectedDate.day ==
                                  DateTime.now().add(Duration(days: i)).day
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    await dateTimePicker(context, terrainCubit);
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: BlocBuilder<TerrainCubit, TerrainState>(
            builder: (context, state) {
              var terrainCubit = TerrainCubit.get(context);
              DateTime date = terrainCubit
                  .selectedDate; // changed with the selectedDate from listview
              String dayOfWeek =
                  DateFormat('EEEE').format(date); // 'Sunday', 'Monday', etc.
              List<dynamic> nonReservableHours =
                  []; //! Initialize with empty list (if no non-reservable hours are available)

              // Populate nonReservableHours based on selected day from nonReservableTimeBlocks
              for (var block in terrainModel.nonReservableTimeBlocks!) {
                if (block.day == dayOfWeek || block.day == 'All') {
                  nonReservableHours.addAll(block.hours!.map((hour) => hour
                      .toString())); // Ensure hours are in string format if they aren't already
                }
              }

              // Assuming operational hours are part of your terrainModel, adjust this to match your actual data structure
              List<String> timeSlots = terrainCubit.generateTimeSlots(
                  terrainModel.sTemps!,
                  terrainModel.eTemps!,
                  nonReservableHours);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 15,
                ),
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  bool isReservable =
                      !nonReservableHours.contains(timeSlots[index]);
                  return GestureDetector(
                    onTap: () {
                      print('Selected time slot: ${timeSlots[index]}');
                      if (isReservable) {
                        String hour = timeSlots[index];
                        print(timeSlots[index]);
                        navigatAndReturn(
                            context: context,
                            page: Reserve(
                                date: terrainCubit.selectedDate,
                                hour: hour,
                                index: index));
                      }
                    },
                    child:
                        itemGridViewReservation(isReservable, timeSlots, index),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column descriptionInfo(double screenHeight, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      // Default style for all spans
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Address: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: terrainModel.adresse!,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(
                    width: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Telephone: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: HomeAdminCubit.get(context)
                              .adminModel!
                              .telephone!
                              .toString(),
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(Icons.groups_2_rounded),
                  const SizedBox(
                    width: 8,
                  ),
                  RichText(
                      text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(
                          text: 'Nombre de joueurs: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "${terrainModel.capacite} joueurs",
                          style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(Icons.sports_soccer_rounded),
                  const SizedBox(
                    width: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(
                            text: 'État du terrain: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: terrainModel.etat!,
                            style:
                                const TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text("More:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 8,
              ),
              Text(
                terrainModel.description!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ToggleButtons togeleReserveOrShowDescription(
      TerrainCubit terrainCubit, BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        terrainCubit.toggleView(index);
      },
      isSelected: [
        !terrainCubit.showStadiumDetails,
        terrainCubit.showStadiumDetails,
      ],
      constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width / 2 - 10, minHeight: 40),
      children: const [
        Text('Reservation'),
        Text('Description'),
      ],
    );
  }

  Stack carouselSliderWithIndicator(CarouselController _controller,
      double screenHeight, TerrainCubit terrainCubit) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: screenHeight * 0.2,
            initialPage: terrainCubit.indexSlide,
            viewportFraction: 1,
            // autoPlay: true,
            enlargeCenterPage: true,

            onPageChanged: (index, reason) {
              terrainCubit.setCurrentSlide(index);
            },
          ),
          items: terrainModel.photos!.isEmpty
              ? [
                  Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 100,
                        ),
                      );
                    },
                  ),
                ]
              : terrainModel.photos!.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.network(
                          imagePath,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  );
                }).toList(),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(terrainModel.photos!.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: terrainCubit.indexSlide == index ? 20.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  color: terrainCubit.indexSlide == index
                      ? Colors.blue
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Container itemGridViewReservation(
      bool isReservable, List<String> timeSlots, int index) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: isReservable ? Colors.tealAccent[100] : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        timeSlots[index],
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> dateTimePicker(
      BuildContext context, TerrainCubit terrainCubit) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: terrainCubit.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != terrainCubit.selectedDate) {
      terrainCubit.selectDate(picked);
    }
  }
}
