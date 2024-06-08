// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/terrain_pagination_model.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';

class SearchTerrain extends StatefulWidget {
  final TextEditingController terrainIdController;
  final Function(TarrainPaginationData)? onTerrainSelected;
  final bool isOnlyMy;

  const SearchTerrain({
    Key? key,
    required this.terrainIdController,
    this.onTerrainSelected,
    required this.isOnlyMy,
  }) : super(key: key);

  @override
  State<SearchTerrain> createState() => _SearchTerrainState();
}

class _SearchTerrainState extends State<SearchTerrain> {
  bool showResults = true;
  TarrainPaginationData? selectedTerrain;
  Timer? _debounce;
  late ScrollController _controller;
  TextEditingController searchController = TextEditingController();
  late final AnnonceJoueurCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = AnnonceJoueurCubit.get(context);

    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange &&
            AnnonceJoueurCubit.get(context).cursorIdTerrain != "") {
          AnnonceJoueurCubit.get(context).searchTerrain(
              isOnlyMy: widget.isOnlyMy,
              cursor: AnnonceJoueurCubit.get(context).cursorIdTerrain,
              nomTerrain: searchController.text);
        }
      });
  }

  void _selectTerrain(TarrainPaginationData terrain) {
    setState(() {
      selectedTerrain = terrain;
      showResults = false;
      widget.terrainIdController.text = terrain.id;
      searchController.text = terrain.nom;
    });
    if (widget.onTerrainSelected != null) {
      widget.onTerrainSelected!(terrain);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    cubit.cursorIdTerrain = '';
    cubit.terrainSearch = [];

    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      AnnonceJoueurCubit.get(context)
          .searchTerrain(nomTerrain: value, isOnlyMy: widget.isOnlyMy);
      showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          TextFormField(
            controller: searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Rechercher un terrain...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
              filled: true,
              fillColor: Colors.white,
              labelStyle: const TextStyle(color: Colors.deepPurple),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
            listener: (context, state) {},
            builder: (context, state) {
              bool hasResults = cubit.terrainSearch.isNotEmpty;
              bool isLoading = state is GetSearchTerrainLoading;
              bool isSearchTextEmpty = searchController.text.isEmpty;
              bool shouldShowResults =
                  hasResults || (isLoading && !isSearchTextEmpty);
              if (!showResults) {
                return const SizedBox();
              } else {
                return Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: Visibility(
                    visible: shouldShowResults,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _controller,
                              itemBuilder: (context, index) {
                                var terrain = cubit.terrainSearch[index];
                                return ListTile(
                                  tileColor: index % 2 == 0
                                      ? Colors.grey.shade100
                                      : Colors.white,
                                  title: Row(
                                    children: [
                                      Text(
                                        terrain.nom,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (terrain.etat == 'disponible')
                                        Icon(
                                          Icons.check_circle,
                                          color: greenConst,
                                          size: 18,
                                        ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Superficie: ${terrain.superficie} m²',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Adresse: ${terrain.adresse}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    print(terrain.id);
                                    _selectTerrain(terrain);
                                    widget.terrainIdController.text =
                                        terrain.id;
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.deepPurple,
                                  ),
                                );
                              },
                              itemCount: cubit.terrainSearch.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ),
                          ),
                          if (isLoading &&
                              !isSearchTextEmpty &&
                              cubit.cursorIdTerrain != '')
                            const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
