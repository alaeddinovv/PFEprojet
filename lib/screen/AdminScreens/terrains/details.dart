import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
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
                        children:
                            List.generate(terrainModel.photos!.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width:
                                terrainCubit.indexSlide == index ? 20.0 : 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
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
              },
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            BlocBuilder<TerrainCubit, TerrainState>(
              builder: (context, state) {
                return ToggleButtons(
                  onPressed: (int index) {
                    terrainCubit.toggleView(index);
                  },
                  isSelected: [
                    !terrainCubit.showStadiumDetails,
                    terrainCubit.showStadiumDetails,
                  ],
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 2 - 10,
                      minHeight: 40),
                  children: const [
                    Text('Reservation'),
                    Text('Description'),
                  ],
                );
              },
            ),
            BlocBuilder<TerrainCubit, TerrainState>(
              builder: (context, state) {
                if (terrainCubit.showStadiumDetails) {
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
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic),
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
                                    // Default style for all spans
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
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            "${terrainModel.capacite} joueurs",
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic)),
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: terrainModel.etat!,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic)),
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
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.035,
                      ),
                      SizedBox(
                        height: screenHeight * 0.08,
                        child: ListView.builder(
                          // Important if using inside SingleChildScrollView
                          scrollDirection: Axis.horizontal,
                          itemCount: 8, // 7 dates + 1 for the DatePicker
                          itemBuilder: (context, index) {
                            if (index < 7) {
                              // DateTime date =
                              //     DateTime.now().add(Duration(days: index));
                              return DateCard(
                                date: dates[index],
                                isSelected: terrainCubit.dateSelected ==
                                    dates[index], // Your logic for isSelected
                                onTap: () {
                                  terrainCubit.setSelectedDate(dates[index]);
                                  print(dates[index]);
                                  // Your logic for what happens when a date is tapped
                                },
                              );
                            } else {
                              // Last item as a button to open DatePicker
                              return GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ImageIcon(
                                        AssetImage(
                                            'assets/images/calendar.png'),
                                        // color: Colors.blue,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: GridView.builder(
                          shrinkWrap:
                              true, // Use it to convert GridView to scroll within Column
                          physics:
                              const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 1.3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: terrainCubit.timeSlots.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Handle the tap event, you can use the Cubit to manage state
                                print(
                                    'Selected time slot: ${terrainCubit.timeSlots[index]}');
                                navigatAndReturn(
                                    context: context,
                                    page: Reserve(
                                      index: index,
                                    ));
                              },
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: terrainCubit.timeSlots[index]
                                          ['isReserved']
                                      ? Colors.grey[300]
                                      : Colors.tealAccent[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  terrainCubit.timeSlots[index]['time'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Handle the picked date, e.g., by using a Cubit/Provider to manage state
      print(picked); // Replace with your actual logic
      TerrainCubit.get(context).setSelectedDate(picked);
    }
  }
}

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCard({
    Key? key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = formatWeekdayDate(date);
    // final dayOfMonth = formatDayOfMonth(date);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        // decoration: BoxDecoration(
        //   color: isSelected ? Colors.blue : Colors.transparent,
        // ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayOfWeek,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
