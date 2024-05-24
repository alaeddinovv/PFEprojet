import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/cubit/main_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/update_form.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/update_mdp.dart';
import 'package:flutter/services.dart';
import 'package:pfeprojet/screen/joueurScreens/reservation/cubit/reservation_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';

import '../../../Model/user_model.dart';
import '../home/home.dart';

class ProfileJoueur extends StatelessWidget {
  const ProfileJoueur({super.key});

  @override
  Widget build(BuildContext context) {
    final DataJoueurModel joueurModel =
        HomeJoueurCubit.get(context).joueurModel!;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(S.of(context).profile,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      drawer: _buildDrawer(context, joueurModel),
      body: BlocConsumer<ProfileJoueurCubit, ProfileJoueurState>(
        listener: (context, state) {},
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (!didPop) {
                navigatAndFinish(context: context, page: const HomeJoueur());
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: joueurModel.photo != null
                        ? NetworkImage(joueurModel.photo!)
                        : const AssetImage('assets/images/user.png')
                            as ImageProvider<Object>,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    joueurModel.username!,
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(context, joueurModel),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, DataJoueurModel joueurModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildListTile(
              context,
              icon: Icons.person_outline,
              title: S.of(context).username,
              subtitle: joueurModel.username!,
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: joueurModel.username!))
                      .then((_) {
                    showToast(
                      msg: S.of(context).copy_username_success,
                      state: ToastStates.error,
                    );
                  });
                },
              ),
            ),
            _buildListTile(context,
                icon: Icons.person,
                title: S.of(context).nom,
                subtitle: joueurModel.nom!),
            _buildListTile(context,
                icon: Icons.person,
                title: S.of(context).prenom,
                subtitle: joueurModel.prenom!),
            _buildListTile(context,
                icon: Icons.location_city,
                title: S.of(context).wilaya,
                subtitle: joueurModel.wilaya!),
            _buildListTile(context,
                icon: Icons.email_outlined,
                title: S.of(context).email,
                subtitle: joueurModel.email!),
            _buildListTile(context,
                icon: Icons.phone,
                title: S.of(context).phone,
                subtitle: joueurModel.telephone!.toString()),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      Widget? trailing}) {
    return ListTile(
      leading: Icon(icon),
      title:
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins()),
      trailing: trailing,
      onTap: () {},
    );
  }

  Drawer _buildDrawer(BuildContext context, DataJoueurModel joueurModel) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: joueurModel.photo != null
                      ? NetworkImage(joueurModel.photo!)
                      : const AssetImage('assets/images/user.png')
                          as ImageProvider<Object>,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home', style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndFinish(context: context, page: const HomeJoueur());
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(S.of(context).modify_profile,
                style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndReturn(
                  context: context, page: const UpdateJoueurForm());
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text(S.of(context).modify_password,
                style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndReturn(context: context, page: UpdateMdpForm());
            },
          ),
          ListTile(
            leading: Icon(Icons.translate),
            title: Text('Change Language', style: GoogleFonts.poppins()),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(S.of(context).change_language,
                      style: GoogleFonts.poppins()),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('French', style: GoogleFonts.poppins()),
                        onTap: () {
                          MainCubit.get(context)
                              .changeLanguage(const Locale('en'));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text('Arabic', style: GoogleFonts.poppins()),
                        onTap: () {
                          MainCubit.get(context)
                              .changeLanguage(const Locale('ar'));
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout', style: GoogleFonts.poppins()),
            onTap: () async {
              await removeFCMTokenJoueur(
                  device: await CachHelper.getData(key: 'deviceInfo'));
              await CachHelper.removdata(key: "TOKEN");
              showToast(
                  msg: S.of(context).disconnect, state: ToastStates.error);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));

              // Reset all Cubits
              HomeJoueurCubit.get(context).resetValue();
              TerrainCubit.get(context).resetValue();
              AnnonceJoueurCubit.get(context).resetValue();
              ProfileJoueurCubit.get(context).resetValue();
              EquipeCubit.get(context).resetValue();
              ReservationJoueurCubit.get(context).resetValue();
            },
          ),
        ],
      ),
    );
  }
}
