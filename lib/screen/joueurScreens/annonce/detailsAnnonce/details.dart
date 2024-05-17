import 'package:flutter/material.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/detailsAnnonce/annonce_other.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/detailsAnnonce/annonce_search_joueur_details.dart';

class DetailsAnnonceChoose extends StatelessWidget {
  final String id;
  final String
      path; // 3la 7sap type li yji mn reservation t3 annonce nkhyr l page
  final bool isMy;
  const DetailsAnnonceChoose(
      {super.key, required this.path, required this.isMy, required this.id});

  @override
  Widget build(BuildContext context) {
    if (path == 'other') {
      return AnnouncementPage(
        id: id,
        isMy: isMy,
      );
    } else if (path == 'search joueur') {
      return AnnonceSearchJoueurDetails(
        id: id,
        isMyAnnonce: isMy,
      );
    } else {
      return const SizedBox();
    }
  }
}
