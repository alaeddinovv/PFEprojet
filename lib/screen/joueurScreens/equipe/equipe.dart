import 'package:flutter/material.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/Model/equipes_model.dart';

import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/addequipe.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/update_equipe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';





import 'package:flutter_bloc/flutter_bloc.dart';


class Equipe extends StatefulWidget {
  const Equipe({Key? key}) : super(key: key);

  @override
  State<Equipe> createState() => _EquipeState();
}

class _EquipeState extends State<Equipe> {
  late ScrollController _controller;
  bool _showList = true; // State to control which view to show

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller = ScrollController()
      ..addListener(() {

        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange

        )

        {
          if (_showList) {
            if (EquipeCubit.get(context).cursorId !="" ) {
              EquipeCubit.get(context).getMyEquipe(cursor: EquipeCubit.get(context).cursorId);
              print('ggggg');

            }

          } else {
            if (EquipeCubit.get(context).cursorid != "") {
              EquipeCubit.get(context).getAllEquipe(cursor: EquipeCubit.get(context).cursorid);
              print('ggggg');

              print(EquipeCubit.get(context).cursorid);
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
                    EquipeCubit.get(context).getAllEquipe(); // Call getAllAnnonce when "All annonces" is selected
                  } else {
                    EquipeCubit.get(context).getMyEquipe(); // Optional: Refresh "My annonces" when switching back
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
                  child: Text('My equipes'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('All Equipes'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _showList ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocConsumer<EquipeCubit, EquipeState>(
                listener: (context, state) {
                  if (state is DeleteEquipeStateGood) {
                    EquipeCubit.get(context)
                        .getMyEquipe()
                        .then((value) => Navigator.pop(context));
                  }
                },
                builder: (context, state) {

                  if (state is GetMyEquipeLoading && EquipeCubit.get(context).cursorId == '') {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.separated(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildEquipeItem(
                          EquipeCubit.get(context).equipeData[index],
                          index,
                          context);
                    },
                    separatorBuilder: (context, int index) => const SizedBox(height: 16),
                    itemCount: EquipeCubit.get(context).equipeData.length,
                    shrinkWrap: true, // to prevent infinite height error
                  );
                  //
                  return const SizedBox();
                },
              ),
            )

            //       SizedBox()
            //---------------------part 2 --------------------------
                :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocConsumer<EquipeCubit, EquipeState>(
                listener: (context, state) {
                  if (state is DeleteEquipeStateGood) {
                    EquipeCubit.get(context)
                        .getAllEquipe()
                        .then((value) => Navigator.pop(context));
                  }

                },
                builder: (context, state) {


                  if (state is GetAllEquipeLoading && EquipeCubit.get(context).cursorid == '') {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.separated(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildAllEquipeItem(
                          EquipeCubit.get(context).equipes[index],
                          index,
                          context);
                    },
                    separatorBuilder: (context, int index) => const SizedBox(height: 16),
                    itemCount: EquipeCubit.get(context).equipes.length,
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
          navigatAndReturn(context: context, page: AddEquipe());
        },
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
//---------------------------------------- myyyyyyyyyyyyyyyyyyyyy
//   Widget buildEquipeList() {
//     return SingleChildScrollView(
//       child:
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: BlocConsumer<EquipeCubit, EquipeState>(
//           listener: (context, state) {
//             if (state is DeleteEquipeStateGood) {
//               EquipeCubit.get(context)
//                   .getMyEquipe()
//                   .then((value) => Navigator.pop(context));
//             }
//           },
//           builder: (context, state) {
//
//             if (state is GetMyEquipeLoading && EquipeCubit.get(context).cursorId == '') {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             return ListView.separated(
//               controller: _controller,
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return _buildEquipeItem(
//                     EquipeCubit.get(context).equipeData[index],
//                     index,
//                     context);
//               },
//               separatorBuilder: (context, int index) => const SizedBox(height: 16),
//               itemCount: EquipeCubit.get(context).equipeData.length,
//               shrinkWrap: true, // to prevent infinite height error
//             );
//             //
//
//           },
//         ),
//       ),
//     );
//   }
//--------------------------------------------------------- allllllllllllllllllllllllllllll
//   Widget buildSimpleView({required ScrollController controller}) {
//     return SingleChildScrollView(
//       child:
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: BlocConsumer<EquipeCubit, EquipeState>(
//           listener: (context, state) {
//             if (state is DeleteEquipeStateGood) {
//               EquipeCubit.get(context)
//                   .getAllEquipe()
//                   .then((value) => Navigator.pop(context));
//             }
//
//           },
//           builder: (context, state) {
//             if (state is GetAllEquipeStateBad) {
//               return const Text('Failed to fetch data');
//             }
//
//             if (state is GetAllEquipeLoading && EquipeCubit.get(context).cursorid == '') {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             return ListView.separated(
//               controller: controller,
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return _buildAllEquipeItem(
//                     EquipeCubit.get(context).equipes[index],
//                     index,
//                     context);
//               },
//               separatorBuilder: (context, int index) => const SizedBox(height: 16),
//               itemCount: EquipeCubit.get(context).equipes.length,
//               shrinkWrap: true, // to prevent infinite height error
//             );
//           },
//         ),
//       ),
//
//     );
//   }
//----------------------------------------------------------------mmmmmmmmmmmmmmmmmmmmmyyyyyyyyyyyyy
  Widget _buildEquipeItem(
      EquipeData model, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 4.0), // Adjusted for visual balance
      decoration: BoxDecoration(
        color: Colors.white, // Maintains a clean background
        border: Border.all(
            color: Colors.blueAccent,
            width: 2), // Slightly thicker border for emphasis
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              model.nom ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18, // Larger font size for prominence
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the Row only takes as much width as it needs
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    navigatAndReturn(
                        context: context,
                        page: EditEquipe(equipeModel: model));
                    // Your code to handle edit action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    dialogDelete(context, model);
                  },
                ),
              ],
            ),
            // contentPadding: const EdgeInsets.symmetric(
            //     horizontal: 12.0, vertical: 8.0), // Adjusted padding for layout
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical:
                8.0), // Padding that slightly indents the description from the border
            child: Text(
              model.nom ?? '', // Display the description
              style: const TextStyle(
                  fontSize: 16), // Slightly larger font for readability
            ),
          ),
        ],
      ),
    );
  }

  //--------------------------------------alallllllllllllllllllllllllllllllllllll
  Widget _buildAllEquipeItem(
      EquipesData model, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 4.0), // Adjusted for visual balance
      decoration: BoxDecoration(
        color: Colors.white, // Maintains a clean background
        border: Border.all(
            color: Colors.blueAccent,
            width: 2), // Slightly thicker border for emphasis
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              model.nom ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18, // Larger font size for prominence
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the Row only takes as much width as it needs
              children: [
                // IconButton(
                //   icon: const Icon(Icons.call, color: Colors.green),
                //   onPressed: () {
                //     int? phoneNumber = model.admin?.telephone ?? model.joueur?.telephone;
                //     if (phoneNumber != null) {
                //       _makePhoneCall(phoneNumber.toString());
                //
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text("No telephone number available."),
                //         ),
                //       );
                //     }
                //   },
                // ),

                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    dialogDeletee(context, model);
                  },
                ),
              ],
            ),
            // contentPadding: const EdgeInsets.symmetric(
            //     horizontal: 12.0, vertical: 8.0), // Adjusted padding for layout
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical:
                8.0), // Padding that slightly indents the description from the border
            child: Text(
              model.nom ?? '', // Display the description
              style: const TextStyle(
                  fontSize: 16), // Slightly larger font for readability
            ),
          ),
        ],
      ),
    );
  }
  //-----------------------------------------------------------------------------

  Future<dynamic> dialogDelete(BuildContext context, EquipeData model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Equipe'),
          content: const Text('Are you sure you want to delete this annonce?'),
          actions: [
            TextButton(
              onPressed: () {
                EquipeCubit.get(context).deleteEquipe(id: model.id!);

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


  Future<dynamic> dialogDeletee(BuildContext context, EquipesData model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Annonce'),
          content: const Text('Are you sure you want to delete this annonce?'),
          actions: [
            TextButton(
              onPressed: () {
                EquipeCubit.get(context).deleteEquipe(id: model.id!);

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
