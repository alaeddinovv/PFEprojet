import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:url_launcher/url_launcher.dart'; // Ensure this path is correct

class MyEquipeDetailsScreen extends StatefulWidget {
   EquipeData equipeData;
  MyEquipeDetailsScreen({super.key, required this.equipeData});

  @override
  State<MyEquipeDetailsScreen> createState() => _MyEquipeDetailsScreenState();
}

class _MyEquipeDetailsScreenState extends State<MyEquipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    // Total count now uses numeroJoueurs from the equipeData
    int totalItems = widget.equipeData.numeroJoueurs;
    int joueurCount = widget.equipeData.joueurs.length;
    int attenteJoueursCount = widget.equipeData.attenteJoueurs.length;
    // int? indexjoueur ;

    return Scaffold(
      appBar: AppBar(
        title: Text('Détail de l\'équipe'), // Display team name
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equipe :${widget.equipeData.nom}', // Display team name at the top of the page
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Capitaine : ${widget.equipeData.capitaineId.username}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded( // Use Expanded for ListView.builder in a Column
              child: BlocConsumer<EquipeCubit, EquipeState>(
                listener: (context, state) {
                  if (state is QuiterEquipeStateGood) {
                    showToast(msg: "Operation successful", state: ToastStates.success);
                    widget.equipeData.joueurs.removeWhere((element) => element.username == 'boulrens');
                    setState(() {

                    });
                    EquipeCubit.get(context).getMyEquipe();

                    // This should re-fetch the equipe data
                  } else if (state is QuiterEquipeStateBad) {
                    showToast(msg: "Failed to perform operation", state: ToastStates.error);
                  } else if (state is ErrorState) {
                    showToast(msg: state.errorModel.message!, state: ToastStates.error);
                  }
                },
                  builder: (context, state) {
                    if (state is QuiterEquipeLoadingState) {
                      return CircularProgressIndicator();  // Show loading indicator while data is being fetched
                    }

                   return ListView.builder(
                      itemCount: totalItems, // Adjust the count as needed
                      itemBuilder: (context, index) {
                        if (index < joueurCount) {
                          Joueurs joueur = widget.equipeData.joueurs[index];
                          return _buildJoueurItem(index, joueur.id, widget
                              .equipeData.id, joueur.username,
                              joueur.telephone );
                        } else if (index < joueurCount + attenteJoueursCount) {
                          return _buildProgressItem(index, widget.equipeData
                              .attenteJoueurs[index -
                              widget.equipeData.joueurs.length]
                              .username); // Use the new progress item for 3rd and 4th items
                        } else {
                          return _buildAddItem(index);
                        }
                      },
                    );
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
  //-------------------- attente---------------------------------------------
  Widget _buildProgressItem(int index , String username) {
    final joueurId = HomeJoueurCubit.get(context).joueurModel!.id;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(username, style: TextStyle(fontSize: 16)),
            ),
            Spacer(),
            Icon(
              Icons.hourglass_empty,  // Simple icon, no interaction
              color: Colors.blue,     // Blue color to signify ongoing progress
              size: 24,               // Icon size for visual balance
            ),
            SizedBox(width: 12,),
            IconButton(
              onPressed: () {
                if (joueurId != null) { // Check if joueurId is not null
                  EquipeCubit.get(context).capitaineAnnuleInvitationJoueur(id: widget.equipeData.id, joueurId: joueurId).then((_) {
                    showToast(msg: "joueur suprimer", state: ToastStates.success);
                    EquipeCubit.get(context).getMyEquipe(); // Refresh the list after refusing
                  }).catchError((error) {
                    showToast(msg: "ressayer", state: ToastStates.error);
                  });
                } else {
                  // Handle the error state here if joueurId is null
                  showToast(
                      msg: "ressayer", state: ToastStates.error);

                }
              },
              icon: Icon(Icons.cancel),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }


//-------------------------------------------------joueur --------------------------
  Widget _buildJoueurItem(int index ,String joueurId, String equipeId, String username ,int? telephone ) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding to the entire row for better spacing
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white, // Adds a background color to the container
          borderRadius: BorderRadius.circular(8), // Rounded corners for a smoother look
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Soft shadow for depth
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // Slight vertical shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Internal padding for text and icons
              child: Text(username, style: TextStyle(fontSize: 16)), // Increased font size for readability
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                int? phoneNumber = telephone;
                if (phoneNumber != null) {
                  _makePhoneCall(phoneNumber.toString());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("No telephone number available."),
                    ),
                  );
                }
              },
              icon: Icon(Icons.call),
              color: Colors.green, // Green color to signify calling is a positive action
            ),

               IconButton(
                  onPressed: () {
                      EquipeCubit.get(context).quiterEquipe(equipeId: equipeId, joueurId: joueurId);
                      // indexjoueur = index;
                  },
                  icon: Icon(Icons.cancel),
                  color: Colors.red,
                ),

          ],
        ),
      ),
    );
  }


//-------------------------------------------------------- add --------------------------------------
  Widget _buildAddItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: () {
          // Add action
          _showAddDialog(context);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Icon(Icons.add, color: Colors.green, size: 24),
        ),
      ),
    );
  }
//------------------------------------ ajouter equipe dialog --------------------------------
  void _showAddDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    bool showText = false; // State to manage visibility of the text

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(  // Enables local state management within the dialog
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("add username:"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: "Enter text here",
                            suffixIcon: TextButton(
                              onPressed: () {
                                setState(() {
                                  showText = true; // Show the text when 'Check' is clicked
                                });
                              },
                              child: Text('Check'),
                            ),
                          ),
                          onChanged: (value) {
                            if (showText) {
                              setState(() {
                                showText = false; // Hide the text when typing starts
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (showText) Text('Hi'), // Conditional rendering of the text
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();  // Close the dialog
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }




  Future<void> _makePhoneCall(String phoneNumber) async {
    print(phoneNumber.runtimeType);
    print(phoneNumber);
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.phone.request();
    }

    if (await Permission.phone.isGranted) {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

      await launchUrl(launchUri);



    } else {
      print('Permission denied');
    }
  }



}
