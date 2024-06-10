// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/reservation_model.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/edite_my_reservation.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/location/terrain_location.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/other_reserve.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/reserve.dart';

// ignore: must_be_immutable
class TerrainDetailsScreen extends StatefulWidget {
  TerrainModel terrainModel;
  TerrainDetailsScreen({super.key, required this.terrainModel});

  @override
  State<TerrainDetailsScreen> createState() => _TerrainDetailsScreenState();
}

class _TerrainDetailsScreenState extends State<TerrainDetailsScreen> {
  List<String> timeSlots = [];
  @override
  void initState() {
    timeSlots = TerrainCubit.get(context).generateTimeSlots(
        widget.terrainModel.heureDebutTemps!,
        widget.terrainModel.heureFinTemps!);
    TerrainCubit.get(context).fetchReservations(
        terrainId: widget.terrainModel.id!,
        date: TerrainCubit.get(context).selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = TerrainCubit.get(context);

    final CarouselController _controller = CarouselController();
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<TerrainCubit, TerrainState>(
      listener: (context, state) {
        if (state is AddReservationStateGood) {
          setState(() async {
            cubit.fetchReservations(
                terrainId: widget.terrainModel.id!, date: cubit.selectedDate);

            await sendNotificationToAdmin(
                adminId: widget.terrainModel.admin!.id!,
                body: 'jour :${state.date} \n heur :${state.houre}',
                title: 'demande de reservation');
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Terrain Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<TerrainCubit, TerrainState>(
                builder: (context, state) {
                  return carouselSliderWithIndicator(
                      _controller, screenHeight, cubit);
                },
              ),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              BlocBuilder<TerrainCubit, TerrainState>(
                builder: (context, state) {
                  return togeleReserveOrShowDescription(cubit, context);
                },
              ),
              BlocBuilder<TerrainCubit, TerrainState>(
                builder: (context, state) {
                  if (cubit.showStadiumDetails) {
                    return descriptionInfo(screenHeight, context);
                  } else {
                    return reservationGrid(screenHeight, cubit, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column reservationGrid(
      double screenHeight, TerrainCubit terrainCubit, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SizedBox(
            height: screenHeight * 0.08,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i < 7; i++)
                  GestureDetector(
                    onTap: () {
                      DateTime selectedDate =
                          DateTime.now().add(Duration(days: i));
                      terrainCubit.selectDate(selectedDate);
                      terrainCubit.fetchReservations(
                        terrainId: widget.terrainModel.id!,
                        date: terrainCubit.selectedDate,
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: terrainCubit.selectedDate.day ==
                                DateTime.now().add(Duration(days: i)).day
                            ? Colors.blue[300]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE')
                                .format(DateTime.now().add(Duration(days: i))),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: terrainCubit.selectedDate.day ==
                                      DateTime.now().add(Duration(days: i)).day
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            DateFormat('d')
                                .format(DateTime.now().add(Duration(days: i))),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: terrainCubit.selectedDate.day ==
                                      DateTime.now().add(Duration(days: i)).day
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    await dateTimePicker(context, terrainCubit);
                    terrainCubit.fetchReservations(
                      terrainId: widget.terrainModel.id!,
                      date: terrainCubit.selectedDate,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: BlocBuilder<TerrainCubit, TerrainState>(
            builder: (context, state) {
              if (state is DeleteDemandeReservationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DeleteDemandeReservationStateGood) {
                TerrainCubit.get(context).fetchReservations(
                    terrainId: widget.terrainModel.id!,
                    date: TerrainCubit.get(context).selectedDate);
                showToast(
                    msg: 'delete demande reservation success',
                    state: ToastStates.success);
              } else if (state is DeleteDemandeReservationStateBad) {
                showToast(
                    msg: 'delete demande reservation failed',
                    state: ToastStates.error);
              }
              if (state is GetReservationLoadingState) {
                return const Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is GetReservationStateBad ||
                  state is ErrorState) {
                return const Center(
                  child: Text('Failed to fetch reservations'),
                );
              } else {
                DateTime date = terrainCubit
                    .selectedDate; // changed with the selectedDate from listview
                String dayOfWeek =
                    DateFormat('EEEE').format(date); // 'Sunday', 'Monday', etc.
                List<String> nonReservableHours =
                    []; //! Initialize with empty list (if no non-reservable hours are available)

                // Populate nonReservableHours based on selected day from nonReservableTimeBlocks
                for (var block
                    in widget.terrainModel.nonReservableTimeBlocks!) {
                  if (block.day == dayOfWeek || block.day == 'All') {
                    nonReservableHours.addAll(block.hours!.map((hour) => hour
                        .toString())); // Ensure hours are in string format if they aren't already
                  }
                }
                List<String> hourPaymentsWithOtherPlayer = [];
                List<String> hourMyReservationWaiting = [];
                List<String> hourMyReservationPaying = [];
                for (var block in terrainCubit.reservationList) {
                  if (block.jour!.month + block.jour!.day + block.jour!.year ==
                      terrainCubit.selectedDate.month +
                          terrainCubit.selectedDate.day +
                          terrainCubit.selectedDate.year) {
                    if (block.joueurId !=
                        HomeJoueurCubit.get(context).joueurModel!.id) {
                      hourPaymentsWithOtherPlayer.add(block.heureDebutTemps!);
                    } else {
                      if (block.payment == false) {
                        hourMyReservationWaiting.add(block.heureDebutTemps!);
                      } else {
                        hourMyReservationPaying.add(block.heureDebutTemps!);
                      }
                    }
                  }
                }

                return Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        bool isCharge = hourPaymentsWithOtherPlayer
                            .contains(timeSlots[index]);
                        bool isMyReservationPaying =
                            hourMyReservationPaying.contains(timeSlots[index]);
                        bool isMyReservation =
                            hourMyReservationWaiting.contains(timeSlots[index]);
                        bool isReservable =
                            !nonReservableHours.contains(timeSlots[index]) &&
                                !isCharge &&
                                !isMyReservation &&
                                !isMyReservationPaying;
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
                                      idTerrain: widget.terrainModel.id!));
                            } else if (isCharge) {
                              navigatAndReturn(
                                  context: context,
                                  page: DetailOtherReserve(
                                    jour: terrainCubit.selectedDate,
                                    heure: timeSlots[index],
                                    terrainId: widget.terrainModel.id!,
                                  ));
                            } else if (isMyReservationPaying) {
                              navigatAndReturn(
                                  context: context,
                                  page: DetailMyReserve(
                                    jour: terrainCubit.selectedDate,
                                    heure: timeSlots[index],
                                    terrainId: widget.terrainModel.id!,
                                  ));
                            } else if (isMyReservation) {
                              // i want when long press show dialog to delete reservation
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    final ReservationModel reserve =
                                        terrainCubit.reservationList.firstWhere(
                                            (element) =>
                                                element.heureDebutTemps ==
                                                timeSlots[index]);
                                    return AlertDialog(
                                      title: const Text(
                                          'Supprimer la réservation'),
                                      content: Text(
                                          'Etes-vous sûr de vouloir supprimer cette réservation ?\n Durée : ${reserve.duree} semaine(s)'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Annuler'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            terrainCubit
                                                .deleteDemandeReservation(
                                                    ReservationId: reserve.id!);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Supprimer'),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          },
                          child: itemGridViewReservation(
                              nonReservableHours,
                              hourPaymentsWithOtherPlayer,
                              hourMyReservationWaiting,
                              hourMyReservationPaying,
                              timeSlots,
                              index),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    _buildColorIndex(),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Padding descriptionInfo(double screenHeight, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildListTile(
                context,
                icon: Icons.sports_soccer_rounded,
                title: 'Nom:',
                subtitle: widget.terrainModel.nom!,
              ),
              _buildListTile(
                context,
                icon: Icons.location_on,
                title: 'Adresse:',
                subtitle: widget.terrainModel.adresse!,
              ),
              _buildListTile(
                context,
                icon: Icons.phone,
                title: 'Téléphone:',
                subtitle: widget.terrainModel.admin!.telephone.toString(),
              ),
              _buildListTile(
                context,
                icon: Icons.groups_2_rounded,
                title: 'Nombre de joueurs:',
                subtitle: "${widget.terrainModel.capacite} joueurs",
              ),
              _buildListTile(
                context,
                icon: Icons.stadium,
                title: 'État du terrain:',
                subtitle: widget.terrainModel.etat!,
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(color: Colors.black),
                  children: [
                    const TextSpan(
                      text: "Description: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    TextSpan(text: widget.terrainModel.description!),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () {
                    navigatAndReturn(
                      context: context,
                      page: LocationTErrain(
                        terrainId: widget.terrainModel.id!,
                        location: LatLng(
                          widget.terrainModel.coordonnee!.latitude!,
                          widget.terrainModel.coordonnee!.longitude!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.location_on_outlined,
                      color: Colors.white),
                  label: const Text(
                    'Voir sur la carte',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    minimumSize:
                        Size(0, 40), // Set the minimum width and height
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16), // Adjust the horizontal padding
                    backgroundColor: greenConst,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
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
      borderRadius: BorderRadius.circular(8),
      fillColor: greenConst,
      color: greenConst,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 2 - 10,
        minHeight: 42, // Increase the height
      ),
      children: [
        Row(
          children: [
            Icon(
              Icons.sports_soccer_rounded,
              color:
                  !terrainCubit.showStadiumDetails ? Colors.white : greenConst,
            ),
            SizedBox(width: 5),
            Text(
              'Reservation',
              style: TextStyle(
                color: !terrainCubit.showStadiumDetails
                    ? Colors.white
                    : greenConst,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.description,
              color:
                  terrainCubit.showStadiumDetails ? Colors.white : greenConst,
            ),
            SizedBox(width: 5),
            Text(
              'Description',
              style: TextStyle(
                color:
                    terrainCubit.showStadiumDetails ? Colors.white : greenConst,
              ),
            ),
          ],
        ),
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
          items: widget.terrainModel.photos!.isEmpty
              ? [
                  Builder(
                    builder: (BuildContext context) {
                      return Image.asset('assets/images/terr.jpg',
                          fit: BoxFit.fill, width: double.infinity);
                    },
                  ),
                ]
              : widget.terrainModel.photos!.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imagePath,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                List.generate(widget.terrainModel.photos!.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: terrainCubit.indexSlide == index ? 20.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  color: terrainCubit.indexSlide == index
                      ? blueConst.withOpacity(0.5)
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
    List<String> isReservable,
    List<String> isCharge,
    List<String> hourMyReservation,
    List<String> hourMyReservationWaiting,
    List<String> timeSlots,
    int index,
  ) {
    Color backgroundColor = greenConst; // Default to green for available slots

    // If the slot is not reservable (blocked), it gets a red color
    if (isReservable.contains(timeSlots[index])) {
      backgroundColor = Colors.red; // Red for non-reservable (blocked) slots
    }
    // If the slot is charged (booked or taken), it gets a gray color
    else if (isCharge.contains(timeSlots[index])) {
      backgroundColor = Colors.grey[300]!; // Gray for charged (booked) slots
    } else if (hourMyReservation.contains(timeSlots[index])) {
      backgroundColor = Colors.amber[300]!;
    } else if (hourMyReservationWaiting.contains(timeSlots[index])) {
      backgroundColor = Colors.blue[300]!;
    }

    return Container(
      height: 20,
      // width: 10,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        timeSlots[index],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> dateTimePicker(
      BuildContext context, TerrainCubit terrainCubit) async {
    final DateTime now = DateTime.now();
    final DateTime lastDate = now.add(Duration(days: 20));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: terrainCubit.selectedDate,
      firstDate: DateTime.now(),
      lastDate: lastDate,
    );
    if (picked != null && picked != terrainCubit.selectedDate) {
      terrainCubit.selectDate(picked);
    }
  }
}

Widget _buildColorIndex() {
  return Card(
    color: Colors.grey[50],
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Index des couleurs :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          _buildColorItem(greenConst, 'Disponible pour réservation'),
          _buildColorItem(
              Colors.red[300]!, 'Bloqué par le propriétaire du stade'),
          _buildColorItem(Colors.grey[300]!, 'Réservé par d\'autres joueurs'),
          _buildColorItem(Colors.blue[300]!, 'Votre réservation approuvée'),
          _buildColorItem(Colors.yellow[300]!, 'Votre réservation en attente'),
        ],
      ),
    ),
  );
}

Widget _buildColorItem(Color color, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        Text(label),
      ],
    ),
  );
}
