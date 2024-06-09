import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propos de nous'),
        backgroundColor: Color(0xFF76A26C),
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
                border: Border.all(color: Color(0xFF76A26C)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nom de l\'application',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF76A26C),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Créé par :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF76A26C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- Guechi HoussamEddine',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Boulrens Ala Eddine',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'À propos de l\'application :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF76A26C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Cette application est conçue pour offrir aux utilisateurs une expérience transparente pour découvrir et réserver divers services. Elle propose un large choix et une commodité inégalée.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nous contacter :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF76A26C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Si vous avez des questions ou des commentaires, n\'hésitez pas à nous contacter à :',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email : crenoDz@gmail.com',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Téléphone : 0776416901',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
