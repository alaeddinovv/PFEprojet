import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/details.dart';
import '../../../Model/annonce_model.dart';

import 'addannonce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/annonce_cubit.dart';


class Annonce extends StatelessWidget {
  const Annonce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AnnonceCubit, AnnonceState>(
      builder: (context, state) {
        if (state is GetMyAnnonceLoading) {
          return CircularProgressIndicator(); // Loading indicator while fetching data
        } else if (state is GetMyAnnonceStateGood) {
          final annonces = state.annonces;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => _buildAnnonceItem(annonces, index),
                separatorBuilder: (context, int index) => const SizedBox(
                  height: 16,
                ),
                itemCount: annonces.length,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigatAndReturn(
                  context: context,
                  page: const AddAnnonce(),
                );
              },
              child: Icon(Icons.add),
            ),
          );
        } else if (state is GetMyAnnonceStateBad) {
          return Text('Failed to fetch data'); // Display a message if fetching data failed
        } else {
          return Text('Unknown state'); // Display a message for unknown state
        }
      },
    );
  }

  Widget _buildAnnonceItem(List<AnnonceModel> annonces, int index) {
    AnnonceModel annonce = annonces[index];
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    annonce.type ?? '', // Display the type
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      // Handle your delete action here
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Text(
                annonce.description ?? '', // Display the description
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
