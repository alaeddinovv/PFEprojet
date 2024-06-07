import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/component/components.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nous contacter'),
        backgroundColor: greenConst,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: greenConst),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nous contacter',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: greenConst,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Si vous avez des questions ou des demandes, veuillez nous contacter à :',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email : contact@example.com',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Téléphone : +1 123-456-7890',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ou envoyez-nous vos suggestions :',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _suggestionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre suggestion ici...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: greenConst),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenConst, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Envoyez la suggestion ici
                  //     String suggestion = _suggestionController.text;
                  //     // Faites quelque chose avec la suggestion (par exemple, envoyez-la à votre backend)
                  //     // ...
                  //     // Effacez le champ de texte après l'envoi
                  //     _suggestionController.clear();
                  //     // Affichez un message de confirmation
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //           content: Text(
                  //               'Votre suggestion a été envoyée. Merci !')),
                  //     );
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: greenConst,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'Envoyer',
                  //     style: GoogleFonts.poppins(color: Colors.white),
                  //   ),
                  // ),
                  defaultSubmit2(text: 'Envoyer', onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
