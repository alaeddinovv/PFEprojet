import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfeprojet/Model/user_model.dart';
import 'package:pfeprojet/generated/l10n.dart';

class OtherJoueurDetails extends StatelessWidget {
  final DataJoueurModel joueurModel;

  OtherJoueurDetails({Key? key, required this.joueurModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).joueurDetails,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
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
      required String subtitle}) {
    return ListTile(
      leading: Icon(icon),
      title:
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins()),
    );
  }
}
