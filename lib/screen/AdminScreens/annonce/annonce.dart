import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
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
          return const Center(
              child:
                  CircularProgressIndicator()); // Loading indicator while fetching data
        } else if (state is GetMyAnnonceStateGood) {
          final annonces = state.annonces;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 20),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    _buildAnnonceItem(annonces[index], index, context),
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
                  page: AddAnnonce(),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        } else if (state is GetMyAnnonceStateBad) {
          return const Text(
              'Failed to fetch data'); // Display a message if fetching data failed
        } else {
          return const Text(
              'Unknown state'); // Display a message for unknown state
        }
      },
    );
  }

  Widget _buildAnnonceItem(
      AnnonceModel model, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 4.0), // Adjusted for visual balance
      decoration: BoxDecoration(
        color: Colors.white, // Maintains a clean background
        border: Border.all(
            color: Colors.blueAccent,
            width: 2), // Slightly thicker border for emphasis
        borderRadius:
            BorderRadius.circular(10), // Softened corners for a modern look
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: HomeAdminCubit.get(context).adminModel!.photo !=
                      null
                  ? NetworkImage(HomeAdminCubit.get(context).adminModel!.photo!)
                  : const AssetImage('assets/images/user.png')
                      as ImageProvider<Object>,
            ), // More prominent icon
            title: Text(
              model.type ?? '', // This makes the title
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18, // Larger font size for prominence
              ),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: () {
                // Placeholder for delete action
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0), // Adjusted padding for layout
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical:
                    8.0), // Padding that slightly indents the description from the border
            child: Text(
              model.description ?? '', // Display the description
              style: const TextStyle(
                  fontSize: 16), // Slightly larger font for readability
            ),
          ),
        ],
      ),
    );
  }
}
