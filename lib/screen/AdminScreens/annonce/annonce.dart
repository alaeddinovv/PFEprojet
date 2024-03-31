import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/update_annonce.dart';
import '../../../Model/annonce_admin_model.dart';

import 'addannonce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/annonce_cubit.dart';

class Annonce extends StatefulWidget {
  const Annonce({Key? key}) : super(key: key);

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange &&
            AnnonceCubit.get(context).cursorId != "") {
          AnnonceCubit.get(context)
              .getMyAnnonce(cursor: AnnonceCubit.get(context).cursorId);
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
        child: BlocConsumer<AnnonceCubit, AnnonceState>(
          listener: (context, state) {
            if (state is DeleteAnnonceStateGood) {
              AnnonceCubit.get(context)
                  .getMyAnnonce()
                  .then((value) => Navigator.pop(context));
            }
            if (state is DeleteAnnonceStateGood) {
              AnnonceCubit.get(context).getMyAnnonce();
            }
          },
          builder: (context, state) {
            if (state is GetMyAnnonceStateBad) {
              return const Text(
                  'Failed to fetch data'); // Display a message if fetching data failed
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildAnnonceItem(
                          AnnonceCubit.get(context).annonceData[index],
                          index,
                          context);
                    },
                    separatorBuilder: (context, int index) => const SizedBox(
                      height: 16,
                    ),
                    itemCount: AnnonceCubit.get(context).annonceData.length,
                  ),
                ),
                if (state is GetMyAnnonceLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
            // Return an empty container by default
          },
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
  }

  Widget _buildAnnonceItem(
      AnnonceAdminData model, int index, BuildContext context) {
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
              model.type ?? '',
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
                        page: EditAnnoncePage(annonceModel: model));
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
              model.description ?? '', // Display the description
              style: const TextStyle(
                  fontSize: 16), // Slightly larger font for readability
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialogDelete(BuildContext context, AnnonceAdminData model) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Annonce'),
            content:
                const Text('Are you sure you want to delete this annonce?'),
            actions: [
              TextButton(
                onPressed: () {
                  AnnonceCubit.get(context).deleteAnnonce(id: model.id!);
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
        });
  }
}
