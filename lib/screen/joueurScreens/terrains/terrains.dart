import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/details.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/location/all_terrain_location.dart';

class Terrain extends StatefulWidget {
  const Terrain({super.key});

  @override
  State<Terrain> createState() => _TerrainState();
}

class _TerrainState extends State<Terrain> {
  bool _showList = true; // State to control which view to show
  late final TerrainCubit cubit;
  @override
  void initState() {
    cubit = TerrainCubit.get(context);
    cubit.getMyTerrains();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TerrainCubit terrainCubit = TerrainCubit.get(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: [_showList, !_showList],
              onPressed: (int index) {
                setState(() {
                  _showList = index == 0;
                });
              },
              borderRadius: BorderRadius.circular(8),
              borderColor: Colors.blue,
              selectedBorderColor: Colors.blueAccent,
              selectedColor: Colors.white,
              fillColor: Colors.lightBlueAccent.withOpacity(0.5),
              constraints: const BoxConstraints(minHeight: 40.0),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('List Terrain'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Map Terrain'),
                ),
              ],
            ),
          ),
          Expanded(
              child: _showList
                  ? BlocBuilder<TerrainCubit, TerrainState>(
                      builder: (context, state) {
                        if (state is ErrorTerrainsState) {
                          return Center(
                            child: Text(state.errorModel.message!),
                          );
                        } else if (state is GetMyTerrainsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, int index) => terrainItem(
                                context: context,
                                terrainModel: terrainCubit.terrains[index]),
                            separatorBuilder: (context, int index) =>
                                const SizedBox(
                                  height: 16,
                                ),
                            itemCount: terrainCubit.terrains.length);
                      },
                    )
                  : TestMap(terrains: terrainCubit.terrains)),
        ],
      ),
    );
  }

  Set<Marker> _getMarkers(List<TerrainModel> terrains) {
    final markers = <Marker>{};
    for (final terrain in terrains) {
      final marker = Marker(
        markerId: MarkerId(terrain.id!), // Use terrain ID for uniqueness
        position: LatLng(
            terrain.coordonnee!.latitude!, terrain.coordonnee!.longitude!),
        infoWindow: InfoWindow(
          title: terrain.adresse,
          snippet: terrain.description,
        ),
      );
      markers.add(marker);
    }
    return markers;
  }

  InkWell terrainItem({required context, required TerrainModel terrainModel}) {
    return InkWell(
      onTap: () {
        navigatAndReturn(
            context: context,
            page: TerrainDetailsScreen(
              terrainModel: terrainModel,
            ));
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: terrainModel.photos!.isNotEmpty
                  ? NetworkImage(terrainModel.photos![0])
                  : const AssetImage('assets/images/terr.jpg')
                      as ImageProvider<Object>,
              height: 180,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                height: 90,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          terrainModel.adresse!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.groups),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(terrainModel.capacite.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.price_check),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('${terrainModel.prix} Da/H')
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
