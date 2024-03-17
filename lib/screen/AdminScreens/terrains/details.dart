import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';

class TerrainDetailsScreen extends StatelessWidget {
  const TerrainDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final terrainCubit = TerrainCubit.get(context);

    final CarouselController _controller = CarouselController();

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
                        initialPage: terrainCubit.indexSlide,
                        viewportFraction: 1,
                        // autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          terrainCubit.setCurrentSlide(index);
                        },
                      ),
                      items: terrainCubit.assetImagePaths.map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
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
                        children: List.generate(
                            terrainCubit.assetImagePaths.length, (index) {
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
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<TerrainCubit, TerrainState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: terrainCubit.dates
                          .map((date) => DateCard(
                                date: date,
                                isSelected: terrainCubit.dateSelected == date,
                                onTap: () => terrainCubit.setSelectedDate(date),
                              ))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<TerrainCubit, TerrainState>(
              builder: (context, state) {
                return Padding(
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
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                    ),
                    itemCount: terrainCubit.timeSlots.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle the tap event, you can use the Cubit to manage state
                          print(
                              'Selected time slot: ${terrainCubit.timeSlots[index]}');
                        },
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.tealAccent[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            terrainCubit.timeSlots[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
