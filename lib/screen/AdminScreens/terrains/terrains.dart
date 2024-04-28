import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/add_terrain.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/details.dart';

class Terrains extends StatelessWidget {
  const Terrains({super.key});

  @override
  Widget build(BuildContext context) {
    TerrainCubit terrainCubit = TerrainCubit.get(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatAndReturn(context: context, page: const AddTerrainPage());
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
        child: BlocBuilder<TerrainCubit, TerrainState>(
          builder: (context, state) {
            if (state is DeleteTerrainStateGood) {
              showToast(
                  msg: "Deleted Successfully", state: ToastStates.success);
              terrainCubit.getMyTerrains();
            }
            if (state is DeleteTerrainStateBad) {
              showToast(msg: "Error Deleting", state: ToastStates.error);
            }
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
                separatorBuilder: (context, int index) => const SizedBox(
                      height: 16,
                    ),
                itemCount: terrainCubit.terrains.length);
          },
        ),
      ),
    );
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
      onLongPress: () {
        // Show a dialog for deleting the item
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete Terrain"),
              content:
                  const Text("Are you sure you want to delete this terrain?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    TerrainCubit.get(context)
                        .deleteTerrain(id: terrainModel.id!);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            terrainModel.photos!.isNotEmpty
                ? CachedNetworkImage(
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: terrainModel.photos![0],
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.asset(
                    'assets/images/terr.jpg',
                    height: 150,
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
