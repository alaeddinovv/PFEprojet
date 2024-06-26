// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/houssem/equipe_model.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';

class SearchEquipe extends StatefulWidget {
  final TextEditingController equipeIdController;
  final Function(EquipeModelData)? onEquipeSelected;
  final bool isOnlyMy;

  const SearchEquipe({
    Key? key,
    required this.equipeIdController,
    this.onEquipeSelected,
    required this.isOnlyMy,
  }) : super(key: key);

  @override
  State<SearchEquipe> createState() => _SearchEquipeState();
}

class _SearchEquipeState extends State<SearchEquipe> {
  bool showResults = true;
  EquipeModelData? selectedEquipe;
  Timer? _debounce;
  late ScrollController _controller;
  TextEditingController searchController = TextEditingController();
  late final TerrainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = TerrainCubit.get(context);

    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange &&
            TerrainCubit.get(context).cursorIdEqeuipe != "") {
          TerrainCubit.get(context).searchEquipe(
              isOnlyMy: widget.isOnlyMy,
              cursor: TerrainCubit.get(context).cursorIdEqeuipe,
              nomEquipe: searchController.text);
        }
      });
  }

  void _selectEquipe(EquipeModelData equipe) {
    setState(() {
      selectedEquipe = equipe;
      showResults = false;
      widget.equipeIdController.text = equipe.id!;
      searchController.text = equipe.nom!;
    });
    if (widget.onEquipeSelected != null) {
      widget.onEquipeSelected!(equipe);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    cubit.cursorIdEqeuipe = '';
    cubit.equipeSearch = [];

    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      TerrainCubit.get(context)
          .searchEquipe(nomEquipe: value, isOnlyMy: widget.isOnlyMy);
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
              hintText: 'Rechercher des équipes...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
              filled: true,
              fillColor: Colors.white,
              labelStyle: const TextStyle(color: Colors.deepPurple),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          BlocConsumer<TerrainCubit, TerrainState>(
            listener: (context, state) {},
            builder: (context, state) {
              bool hasResults = cubit.equipeSearch.isNotEmpty;
              bool isLoading = state is GetSearchEquipeLoading;
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
                                var equipe = cubit.equipeSearch[index];
                                return ListTile(
                                  tileColor: index % 2 == 0
                                      ? Colors.grey.shade100
                                      : Colors.white,
                                  title: Text(
                                    equipe.nom!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Capitaine: ${equipe.capitaineId!.nom}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    print(equipe.id);
                                    _selectEquipe(equipe);
                                    widget.equipeIdController.text = equipe.id!;
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.deepPurple,
                                  ),
                                );
                              },
                              itemCount: cubit.equipeSearch.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ),
                          ),
                          if (isLoading &&
                              !isSearchTextEmpty &&
                              cubit.cursorIdEqeuipe != '')
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
