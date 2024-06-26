import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/tpggleButtons.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/details.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/location/all_terrain_location.dart';
import 'package:pfeprojet/generated/l10n.dart';

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

    return RefreshIndicator(
      onRefresh: () {
        terrainCubit.getMyTerrains();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtonsWidget(
                icon1: Icons.list_outlined,
                icon2: Icons.location_on_outlined,
                text1: S.of(context).list_terrain,
                text2: S.of(context).map_terrain,
                showList: _showList,
                onToggle: (value) {
                  setState(() {
                    _showList = value;
                  });
                },
              ),
            ),
            Expanded(
              child: _showList
                  ? BlocBuilder<TerrainCubit, TerrainState>(
                      builder: (context, state) {
                        if (state is ErrorTerrainsState) {
                          return Center(
                            child: Text(
                              state.errorModel.message!,
                              style: TextStyle(color: Colors.red),
                            ),
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
                          itemCount: terrainCubit.terrains.length,
                        );
                      },
                    )
                  : TestMap(terrains: terrainCubit.terrains),
            ),
          ],
        ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/image-load-failed.png', // Path to your error image
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            terrainModel.adresse!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.groups, color: greenConst),
                        const SizedBox(width: 5),
                        Text(
                          terrainModel.capacite.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.price_check, color: greenConst),
                        const SizedBox(width: 5),
                        Text(
                          '${terrainModel.prix} ${S.of(context).da_h}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
