import 'package:flutter/material.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/annonce/annonce_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/tpggleButtons.dart';
import 'package:pfeprojet/generated/l10n.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/detailsAnnonce/details.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/addannonce.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
import '../../../Model/annonce/annonce_admin_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Annonce extends StatefulWidget {
  const Annonce({Key? key}) : super(key: key);

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  bool checkBox = false;
  String createur = 'joueur';

  late ScrollController _controller;
  bool _showList = true; // State to control which view to show
  late final AnnonceJoueurCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = AnnonceJoueurCubit.get(context);
    cubit.getMyAnnonceJoueur();
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
                  cursor: AnnonceJoueurCubit.get(context).cursorid,
                  myId: HomeJoueurCubit.get(context).joueurModel!.id,
                  createur: createur);
              print('gggffgg');

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
            child: ToggleButtonsWidget(
              icon1: Icons.list_outlined,
              icon2: Icons.list_outlined,
              text1: S.of(context).my_annonces,
              text2: S.of(context).all_annonces,
              showList: _showList,
              onToggle: (value) {
                setState(() {
                  _showList = value;
                  if (!_showList) {
                    AnnonceJoueurCubit.get(context).getAllAnnonce(
                        myId: HomeJoueurCubit.get(context).joueurModel!.id,
                        createur:
                            createur); // Call getAllAnnonce  owner: HomeJoueurCubit.get(context).joueurModel!.idwhen "All annonces" is selected
                  } else {
                    AnnonceJoueurCubit.get(context)
                        .getMyAnnonceJoueur(); // Optional: Refresh "My annonces" when switching back
                  }
                });
              },
            ),
          ),
          if (!_showList)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'propriétaire de Terrain',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: greenConst,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: checkBox,
                        onChanged: (value) {
                          setState(() {
                            checkBox = value!;
                            if (checkBox == true) {
                              createur = 'admin';
                            } else {
                              createur = 'joueur';
                            }

                            // EquipeCubit.get(context).getMyEquipe(vertial: createur);
                            AnnonceJoueurCubit.get(context).getAllAnnonce(
                                myId: HomeJoueurCubit.get(context)
                                    .joueurModel!
                                    .id,
                                createur: createur);
                          });
                        },
                        activeColor: greenConst,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(color: greenConst),
                      ),
                    ),
                  ],
                ),
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
                        } else if (state is UpdateAnnonceJoueurStateGood) {
                          AnnonceJoueurCubit.get(context).getMyAnnonceJoueur();
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
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
                      listener: (context, state) {
                        if (state is DeleteAnnonceJoueurStateGood) {
                          AnnonceJoueurCubit.get(context)
                              .getAllAnnonce(
                                  myId: HomeJoueurCubit.get(context)
                                      .joueurModel!
                                      .id,
                                  createur: createur)
                              .then((value) => Navigator.pop(context));
                        } else if (state is UpdateAnnonceJoueurStateGood) {
                          AnnonceJoueurCubit.get(context).getAllAnnonce(
                              myId:
                                  HomeJoueurCubit.get(context).joueurModel!.id);
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
            } else if (state is UpdateAnnonceJoueurStateGood) {
              AnnonceJoueurCubit.get(context).getMyAnnonceJoueur();
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
                  .getAllAnnonce(
                      myId: HomeJoueurCubit.get(context).joueurModel!.id,
                      createur: createur)
                  .then((value) => Navigator.pop(context));
            } else if (state is UpdateAnnonceJoueurStateGood) {
              AnnonceJoueurCubit.get(context).getAllAnnonce(
                  myId: HomeJoueurCubit.get(context).joueurModel!.id,
                  createur: createur);
            }
          },
          builder: (context, state) {
            if (state is GetAllAnnonceStateBad) {
              return Text(S.of(context).failed_to_fetch_data);
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
    IconData getIconForType(String? type) {
      switch (type) {
        case 'other':
          return Icons.info;
        case 'search joueur':
          return Icons.person_search;
        case 'search join equipe':
          return Icons.group_add;
        case 'Perte de propriété':
          return Icons.group_add;
        case 'Concernant le timing':
          return Icons.group_add;

        default:
          return Icons.help;
      }
    }

    Color getColorForType(String? type) {
      switch (type) {
        case 'other':
          return const Color(0xFF76A26C); // Green
        case 'search_joueur':
          return const Color(0xFF6E8898); // Light Slate Gray
        case 'search_join_equipe':
          return const Color(0xFF93385F); // Purple
        default:
          return const Color(0xFF333D79); // Navy Blue
      }
    }

    return Container(
      //   margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      // decoration: BoxDecoration(
      // color: Colors.white,
      // border: Border.all(color: greenConst, width: 1), // Softer blue border
      // borderRadius: BorderRadius.circular(10.0),

      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              navigatAndReturn(
                context: context,
                page: DetailsAnnonceChoose(
                  path: model.type!,
                  isMy: true,
                  id: model.id!,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: getColorForType(model.type),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      getIconForType(model.type),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.type ?? '',
                          style: TextStyle(
                            color: getColorForType(model.type),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          model.description ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: getColorForType(model.type),
                    onPressed: () {
                      dialogDelete(context, model);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //--------------------------------------alallllllllllllllllllllllllllllllllllll
  Widget _buildAllAnnonceItem(
      AnnonceData model, int index, BuildContext context) {
    IconData getIconForType(String? type) {
      switch (type) {
        case 'other':
          return Icons.info;
        case 'search joueur':
          return Icons.person_search;
        case 'search join equipe':
          return Icons.group_add;
        case 'Perte de propriété':
          return Icons.search;
        case 'Concernant le timing':
          return Icons.timer;
        default:
          return Icons.help;
      }
    }

    Color getColorForType(String? type) {
      switch (type) {
        case 'other':
          return const Color(0xFF76A26C); // Green
        case 'search_joueur':
          return const Color(0xFF6E8898); // Light Slate Gray
        case 'search_join_equipe':
          return const Color(0xFF93385F); // Purple
        case 'Perte de propriété':
          return Color.fromARGB(255, 3, 57, 60); // Purple
        case 'Concernant le timing':
          return Color.fromARGB(255, 34, 0, 15); // Purple
        default:
          return const Color(0xFF333D79); // Navy Blue
      }
    }

    return Container(
      //  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      // decoration: BoxDecoration(
      //  color: Colors.white,
      // border: Border.all(color: greenConst, width: 1),
      // borderRadius: BorderRadius.circular(10.0),

      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              navigatAndReturn(
                context: context,
                page: DetailsAnnonceChoose(
                  path: model.type!,
                  isMy: false,
                  id: model.id!,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: getColorForType(model.type),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      getIconForType(model.type),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.type ?? '',
                          style: TextStyle(
                            color: getColorForType(model.type),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          model.joueur?.nom ?? model.admin?.nom ?? '',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.call),
                    color: getColorForType(model.type),
                    onPressed: () {
                      int? phoneNumber =
                          model.admin?.telephone ?? model.joueur?.telephone;
                      if (phoneNumber != null) {
                        _makePhoneCall(phoneNumber.toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                S.of(context).no_telephone_number_available),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //-----------------------------------------------------------------------------

  Future<dynamic> dialogDelete(BuildContext context, AnnonceAdminData model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).delete_annonce),
          content:
              Text(S.of(context).are_you_sure_you_want_to_delete_this_annonce),
          actions: [
            TextButton(
              onPressed: () {
                AnnonceJoueurCubit.get(context)
                    .deleteAnnonceJoueur(id: model.id!);
              },
              child: Text(S.of(context).yes),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).no),
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
