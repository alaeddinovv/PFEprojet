import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/details.dart';

class Terrain extends StatelessWidget {
  const Terrain({super.key});

  @override
  Widget build(BuildContext context) {
    TerrainCubit terrainCubit = TerrainCubit.get(context);

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
        child: BlocBuilder<TerrainCubit, TerrainState>(
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
