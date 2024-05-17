import 'package:flutter/material.dart';
import 'package:pfeprojet/Model/annonce_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/detailsAnnonce/search_joueur_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:pfeprojet/screen/joueurScreens/annonce/addannonce.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/update_annonce.dart';
import '../../../Model/annonce_admin_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Annonce extends StatefulWidget {
  const Annonce({Key? key}) : super(key: key);

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  late ScrollController _controller;
  bool _showList = true; // State to control which view to show

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange) {
          if (_showList) {
            if (AnnonceJoueurCubit.get(context).cursorId != "") {
              AnnonceJoueurCubit.get(context).getMyAnnonceJoueur(
                  cursor: AnnonceJoueurCubit.get(context).cursorId);
              print('ggggg');
            }
          } else {
            if (AnnonceJoueurCubit.get(context).cursorid != "") {
              AnnonceJoueurCubit.get(context).getAllAnnonce(
                  cursor: AnnonceJoueurCubit.get(context).cursorid);
              print('ggggg');

              print(AnnonceJoueurCubit.get(context).cursorid);
            }
          }
        }
      });
    // _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (!_showList) {
                    AnnonceJoueurCubit.get(context)
                        .getAllAnnonce(); // Call getAllAnnonce when "All annonces" is selected
                  } else {
                    AnnonceJoueurCubit.get(context)
                        .getMyAnnonceJoueur(); // Optional: Refresh "My annonces" when switching back
                  }
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
                  child: Text('My annonces'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('All annonces'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _showList
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
                      listener: (context, state) {
                        if (state is DeleteAnnonceJoueurStateGood) {
                          AnnonceJoueurCubit.get(context)
                              .getMyAnnonceJoueur()
                              .then((value) => Navigator.pop(context));
                        }
                      },
                      builder: (context, state) {
                        if (state is GetMyAnnonceJoueurLoading &&
                            AnnonceJoueurCubit.get(context).cursorId == '') {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return ListView.separated(
                          controller: _controller,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildAnnonceItem(
                                AnnonceJoueurCubit.get(context)
                                    .annonceData[index],
                                index,
                                context);
                          },
                          separatorBuilder: (context, int index) =>
                              const SizedBox(height: 16),
                          itemCount: AnnonceJoueurCubit.get(context)
                              .annonceData
                              .length,
                          shrinkWrap: true, // to prevent infinite height error
                        );
                        //
                        return const SizedBox();
                      },
                    ),
                  )

                //       SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
                      listener: (context, state) {
                        if (state is DeleteAnnonceJoueurStateGood) {
                          AnnonceJoueurCubit.get(context)
                              .getAllAnnonce()
                              .then((value) => Navigator.pop(context));
                        }
                      },
                      builder: (context, state) {
                        if (state is GetAllAnnonceLoading &&
                            AnnonceJoueurCubit.get(context).cursorid == '') {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return ListView.separated(
                          controller: _controller,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildAllAnnonceItem(
                                AnnonceJoueurCubit.get(context).annonces[index],
                                index,
                                context);
                          },
                          separatorBuilder: (context, int index) =>
                              const SizedBox(height: 16),
                          itemCount:
                              AnnonceJoueurCubit.get(context).annonces.length,
                          shrinkWrap: true, // to prevent infinite height error
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: _showList
          ? FloatingActionButton(
              onPressed: () {
                navigatAndReturn(context: context, page: const AddAnnonce());
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

//---------------------------------------- myyyyyyyyyyyyyyyyyyyyy
  Widget buildAnnonceList() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
          listener: (context, state) {
            if (state is DeleteAnnonceJoueurStateGood) {
              AnnonceJoueurCubit.get(context)
                  .getMyAnnonceJoueur()
                  .then((value) => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            if (state is GetMyAnnonceJoueurLoading &&
                AnnonceJoueurCubit.get(context).cursorId == '') {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildAnnonceItem(
                    AnnonceJoueurCubit.get(context).annonceData[index],
                    index,
                    context);
              },
              separatorBuilder: (context, int index) =>
                  const SizedBox(height: 16),
              itemCount: AnnonceJoueurCubit.get(context).annonceData.length,
              shrinkWrap: true, // to prevent infinite height error
            );
            //
          },
        ),
      ),
    );
  }

//--------------------------------------------------------- allllllllllllllllllllllllllllll
  Widget buildSimpleView({required ScrollController controller}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
          listener: (context, state) {
            if (state is DeleteAnnonceJoueurStateGood) {
              AnnonceJoueurCubit.get(context)
                  .getAllAnnonce()
                  .then((value) => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            if (state is GetAllAnnonceStateBad) {
              return const Text('Failed to fetch data');
            }

            if (state is GetAllAnnonceLoading &&
                AnnonceJoueurCubit.get(context).cursorid == '') {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildAllAnnonceItem(
                    AnnonceJoueurCubit.get(context).annonces[index],
                    index,
                    context);
              },
              separatorBuilder: (context, int index) =>
                  const SizedBox(height: 16),
              itemCount: AnnonceJoueurCubit.get(context).annonces.length,
              shrinkWrap: true, // to prevent infinite height error
            );
          },
        ),
      ),
    );
  }

//----------------------------------------------------------------mmmmmmmmmmmmmmmmmmmmmyyyyyyyyyyyyy
  Widget _buildAnnonceItem(
      AnnonceAdminData model, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.blueAccent, width: 1), // Softer blue border
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // Elevated shadow effect
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              navigatAndReturn(
                context: context,
                page: AnnonceSearchJoueurDetails(
                  id: model.id!,
                ),
              );
            },
            title: Text(
              model.type ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Ensures compactness
              children: [
                IconButton(
                  icon: const Icon(Icons.edit,
                      color: Color(0xFF4CAF50)), // Softer green
                  onPressed: () {
                    navigatAndReturn(
                        context: context,
                        page: EditAnnoncePage(annonceModel: model));
                    // Your code to handle edit action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Color(0xFFBDBDBD)), // Softer grey
                  onPressed: () {
                    dialogDelete(context, model);
                    // Your code to handle delete action
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              model.description ?? '', // Display the description
              style: const TextStyle(
                fontSize: 16, // Readability enhancement
                color: Colors.black54, // Softer text color
              ),
            ),
          ),
        ],
      ),
    );
  }

  //--------------------------------------alallllllllllllllllllllllllllllllllllll
  Widget _buildAllAnnonceItem(
      AnnonceData model, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueAccent, width: 1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              navigatAndReturn(
                context: context,
                page: AnnonceSearchJoueurDetails(
                  id: model.id!,
                ),
              );
            },
            title: Text(
              model.type ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18, // Larger font size for prominence
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Keeps the Row compact
              children: [
                IconButton(
                  icon: const Icon(Icons.call,
                      color: Color(0xFF4CAF50)), // Softer green
                  onPressed: () {
                    int? phoneNumber =
                        model.admin?.telephone ?? model.joueur?.telephone;
                    if (phoneNumber != null) {
                      _makePhoneCall(phoneNumber.toString());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No telephone number available."),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              model.description ?? '', // Display the description
              style: const TextStyle(
                fontSize: 16, // Slightly larger font for readability
                color: Colors.black54, // Softer text color
              ),
            ),
          ),
        ],
      ),
    );
  }

  //-----------------------------------------------------------------------------

  Future<dynamic> dialogDelete(BuildContext context, AnnonceAdminData model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Annonce'),
          content: const Text('Are you sure you want to delete this annonce?'),
          actions: [
            TextButton(
              onPressed: () {
                AnnonceJoueurCubit.get(context)
                    .deleteAnnonceJoueur(id: model.id!);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    print(phoneNumber.runtimeType);
    print(phoneNumber);
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.phone.request();
    }

    if (await Permission.phone.isGranted) {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

      await launchUrl(launchUri);
    } else {
      print('Permission denied');
    }
  }
}
