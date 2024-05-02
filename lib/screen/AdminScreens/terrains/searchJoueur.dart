import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async'; // Import dart:async to use Timer
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';

class SearchTest extends StatefulWidget {
  const SearchTest({super.key});

  @override
  State<SearchTest> createState() => _SearchTestState();
}

class _SearchTestState extends State<SearchTest> {
  Timer? _debounce;
  late ScrollController _controller;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange &&
            TerrainCubit.get(context).cursorId != "") {
          print('ffff');

          TerrainCubit.get(context).searchJoueur(
              cursor: TerrainCubit.get(context).cursorId,
              username: searchController.text);
        }
      });
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Cancel the timer when the widget is disposed
    searchController.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Test'),
        backgroundColor: Colors.deepPurple, // Updated color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<TerrainCubit, TerrainState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                TextFormField(
                  controller: searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                  ),
                ),
                const SizedBox(height: 20),
                if (state is GetSearchJoueurLoading &&
                    TerrainCubit.get(context).cursorId == '')
                  const Center(child: CircularProgressIndicator()),
                Expanded(
                  child: ListView.separated(
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 250,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: TerrainCubit.get(context)
                                          .joueursSearch[index]
                                          .photo !=
                                      null
                                  ? NetworkImage(TerrainCubit.get(context)
                                      .joueursSearch[index]
                                      .photo!)
                                  : const AssetImage('assets/images/user.png')
                                      as ImageProvider,
                            ),
                            title: Text(TerrainCubit.get(context)
                                .joueursSearch[index]
                                .username!),
                            subtitle: Text(
                                'Age: ${TerrainCubit.get(context).joueursSearch[index].age} - Post: ${TerrainCubit.get(context).joueursSearch[index].poste}'),
                          ),
                        ),
                      );
                    },
                    itemCount: TerrainCubit.get(context).joueursSearch.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
                if (state is GetSearchJoueurLoading &&
                    TerrainCubit.get(context).cursorId != '')
                  const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
