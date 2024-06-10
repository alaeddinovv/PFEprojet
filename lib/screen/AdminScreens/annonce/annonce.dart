import 'package:flutter/material.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/detailsAnnonce/annonce_other.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/update_annonce.dart';
import '../../../Model/annonce/annonce_admin_model.dart';
import 'addannonce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/annonce_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';

class Annonce extends StatefulWidget {
  const Annonce({Key? key}) : super(key: key);

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  late final AnnonceCubit cubit;
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    cubit = AnnonceCubit.get(context);
    cubit.getMyAnnonce();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange &&
            AnnonceCubit.get(context).cursorId != "") {
          print('ffff');

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
          },
          builder: (context, state) {
            if (state is GetMyAnnonceStateBad) {
              return Text(S.of(context).failed_to_fetch_data);
            }
            if (state is GetMyAnnonceLoading &&
                AnnonceCubit.get(context).cursorId == '') {
              return const Center(
                child: CircularProgressIndicator(),
              );
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
                if (state is GetMyAnnonceLoading &&
                    AnnonceCubit.get(context).cursorId != '')
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: greenConst, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              navigatAndReturn(
                  context: context,
                  page: AnnouncementPage(
                    id: model.id!,
                  ));
            },
            title: Text(
              model.type ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: greenConst),
                  onPressed: () {
                    navigatAndReturn(
                        context: context,
                        page: EditAnnoncePage(annonceModel: model));
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
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              model.description ?? '',
              style: const TextStyle(fontSize: 16),
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
            title: Text(S.of(context).delete_announcement),
            content: Text(S.of(context).delete_announcement_confirmation),
            actions: [
              TextButton(
                onPressed: () {
                  AnnonceCubit.get(context).deleteAnnonce(id: model.id!);
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
        });
  }
}
