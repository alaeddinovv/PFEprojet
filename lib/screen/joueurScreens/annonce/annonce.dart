import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';


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
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange &&
            AnnonceJoueurCubit.get(context).cursorId != "") {
          AnnonceJoueurCubit.get(context)
              .getMyAnnonceJoueur(cursor: AnnonceJoueurCubit.get(context).cursorId);
        }
      });
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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('My annonces'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('All annonces'),
                ),
              ],
              isSelected: [_showList, !_showList],
              onPressed: (int index) {
                setState(() {
                  _showList = index == 0;
                });
              },
              borderRadius: BorderRadius.circular(8),
              borderColor: Colors.blue,
              selectedBorderColor: Colors.blueAccent,
              selectedColor: Colors.white,
              fillColor: Colors.lightBlueAccent.withOpacity(0.5),
              constraints: BoxConstraints(minHeight: 40.0),
            ),
          ),
          Expanded(
            child: _showList ? buildAnnonceList() : buildSimpleView(),
          ),
        ],
      ),
      floatingActionButton: _showList
          ? FloatingActionButton(
        onPressed: () {
          navigatAndReturn(context: context, page: AddAnnonce());
        },
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
//----------------------------------------
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
            if (state is GetMyAnnonceJoueurStateBad) {
              return const Text('Failed to fetch data');
            }
            if (state is GetMyAnnonceJoueurLoading && AnnonceJoueurCubit.get(context).cursorId == '') {
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
              separatorBuilder: (context, int index) => const SizedBox(height: 16),
              itemCount: AnnonceJoueurCubit.get(context).annonceData.length,
              shrinkWrap: true, // to prevent infinite height error
            );
          },
        ),
      ),
    );
  }
//---------------------------------------------------------
  Widget buildSimpleView() {
    return const Center(
      child: Text(
        'Annonce',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
//----------------------------------------------------------------
  Widget _buildAnnonceItem(AnnonceAdminData model, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(model.type ?? ''),
        subtitle: Text(model.description ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.green),
              onPressed: () {
                navigatAndReturn(
                    context: context,
                    page: EditAnnoncePage(annonceModel: model));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => dialogDelete(context, model),
            ),
          ],
        ),
      ),
    );
  }

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
                AnnonceJoueurCubit.get(context).deleteAnnonceJoueur(id: model.id!);

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
}
