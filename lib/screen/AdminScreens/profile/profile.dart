import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/Api/color.dart';

import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/component/contact_us.dart';
import 'package:pfeprojet/cubit/main_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/update_form.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/update_mdp.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final DataAdminModel adminModel = HomeAdminCubit.get(context).adminModel!;

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
        title: Text('Profile',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      drawer: _buildDrawer(context, adminModel),
      body: BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (!didPop) {
                navigatAndFinish(context: context, page: const HomeAdmin());
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: adminModel.photo != null
                        ? NetworkImage(adminModel.photo!)
                        : const AssetImage('assets/images/football.png')
                            as ImageProvider<Object>,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    adminModel.nom!,
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(context, adminModel),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, DataAdminModel adminModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildListTile(context,
                icon: Icons.person, title: 'Nom', subtitle: adminModel.nom!),
            _buildListTile(context,
                icon: Icons.person,
                title: 'Prenom',
                subtitle: adminModel.prenom!),
            _buildListTile(context,
                icon: Icons.location_city,
                title: 'Wilaya',
                subtitle: adminModel.wilaya!),
            _buildListTile(context,
                icon: Icons.email, title: 'Email', subtitle: adminModel.email!),
            _buildListTile(context,
                icon: Icons.phone,
                title: 'Phone',
                subtitle: adminModel.telephone!.toString()),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return ListTile(
      leading: Icon(icon),
      title:
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins()),
      onTap: () {},
    );
  }

  Drawer _buildDrawer(BuildContext context, DataAdminModel adminModel) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: greenConst),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: adminModel.photo != null
                      ? NetworkImage(adminModel.photo!)
                      : const AssetImage('assets/images/football.png')
                          as ImageProvider<Object>,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil', style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndFinish(context: context, page: const HomeAdmin());
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              S.of(context).modify_profile,
            ),
            onTap: () {
              navigatAndReturn(
                context: context,
                page: const UpdateAdminForm(),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text(S.of(context).modify_password),
            onTap: () {
              navigatAndReturn(
                context: context,
                page: UpdateMdpForm(),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.translate),
            title: Text('Changer la langue', style: GoogleFonts.poppins()),
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
                        title: Text('Français', style: GoogleFonts.poppins()),
                        onTap: () {
                          MainCubit.get(context)
                              .changeLanguage(const Locale('en'));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text('العربية', style: GoogleFonts.poppins()),
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
            textColor: Colors.red,
            iconColor: Colors.red,
            leading: Icon(Icons.exit_to_app),
            title: Text('Se déconnecter', style: GoogleFonts.poppins()),
            onTap: () async {
              removeFCMTokenAdmin(
                      device: await CachHelper.getData(key: 'deviceInfo'))
                  .then((value) {
                navigatAndFinish(context: context, page: Login());
                CachHelper.removdata(key: "TOKEN");
                showToast(msg: "Déconnexion", state: ToastStates.error);
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('contacter Nous', style: GoogleFonts.poppins()),
            onTap: () {
              // Navigate to the Contact Us screen or perform any desired action
              // For example:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
