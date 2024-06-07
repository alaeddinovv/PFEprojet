// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/user_model.dart';

import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';

class SearchTest extends StatefulWidget {
  final TextEditingController userIdController;

  const SearchTest({
    Key? key,
    required this.userIdController,
  }) : super(key: key);

  @override
  State<SearchTest> createState() => _SearchTestState();
}

class _SearchTestState extends State<SearchTest> {
  bool showResults = true;
  DataJoueurModel? selectedJoueur;
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
            TerrainCubit.get(context).moreDataAvailable) {
          TerrainCubit.get(context).searchJoueur(
              page: TerrainCubit.get(context).currentPage + 1,
              username: searchController.text);
        }
      });
  }

  void _selectJoueur(DataJoueurModel joueur) {
    setState(() {
      selectedJoueur = joueur;
      showResults = false;
      widget.userIdController.text = joueur.id!;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    cubit.currentPage = 1;
    cubit.moreDataAvailable = true;
    cubit.joueursSearch = [];

    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      TerrainCubit.get(context).searchJoueur(username: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search players...',
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
                bool hasResults = cubit.joueursSearch.isNotEmpty;
                bool isLoading = state is GetSearchJoueurLoading;
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
                        height: 250,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _controller,
                                itemBuilder: (context, index) {
                                  var joueur = cubit.joueursSearch[index];
                                  return Card(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 4,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: joueur.photo != null
                                            ? NetworkImage(joueur.photo!)
                                            : const AssetImage(
                                                    'assets/images/football.png')
                                                as ImageProvider,
                                      ),
                                      title: Text(joueur.username!),
                                      subtitle: Text(
                                          'Age: ${joueur.age} - Position: ${joueur.poste}'),
                                      onTap: () {
                                        print(joueur.id);
                                        _selectJoueur(joueur);
                                        widget.userIdController.text =
                                            joueur.id!;
                                      },
                                    ),
                                  );
                                },
                                itemCount: cubit.joueursSearch.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            ),
                            if (isLoading &&
                                !isSearchTextEmpty &&
                                cubit.moreDataAvailable)
                              const CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
