// import 'package:flutter/material.dart';
// import 'package:pfeprojet/screen/joueurScreens/reservation/cubit/reservation_cubit.dart';
// import 'package:pfeprojet/screen/joueurScreens/reservation/equipe_reserve_details.dart';

// class EquipeReserveDetials extends StatefulWidget {
//   const EquipeReserveDetials({super.key});

//   @override
//   _EquipeReserveDetialsState createState() => _EquipeReserveDetialsState();
// }

// class _EquipeReserveDetialsState extends State<EquipeReserveDetials> {
//   bool _showList = true;
//   late ReservationJoueurCubit cubit;
//   late ScrollController _controller;

//   @override
//   void initState() {
//     cubit = ReservationJoueurCubit.get(context);
//     cubit.getEquipesDemander();

//     _controller = ScrollController()
//       ..addListener(() {
//         if (_controller.offset >= _controller.position.maxScrollExtent &&
//             !_controller.position.outOfRange) {
//           if (_showList) {
//             if (ReservationJoueurCubit.get(context).cursorid != "") {
//               print('ffff');
//               ReservationJoueurCubit.get(context).getEquipesDemander(
//                   cursor: ReservationJoueurCubit.get(context).cursorid);
//             }
//           }
//         }
//       });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Reservations')),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ToggleButtons(
//                 isSelected: [_showList, !_showList],
//                 onPressed: (int index) {
//                   setState(() {
//                     _showList = index == 0;
//                     if (!_showList) {
//                       ReservationJoueurCubit.get(context).getEquipesDemander(
//                           cursor: ReservationJoueurCubit.get(context).cursorid);
//                     } else {}
//                   });
//                 },
//                 borderRadius: BorderRadius.circular(8),
//                 borderColor: Colors.blue,
//                 selectedBorderColor: Colors.blueAccent,
//                 selectedColor: Colors.white,
//                 fillColor: Colors.lightBlueAccent.withOpacity(0.5),
//                 constraints: const BoxConstraints(minHeight: 40.0),
//                 children: const <Widget>[
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: Text('Reservations Terrain'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: Text('Demander equipe'),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Reservations or Demands List
//             _showList
//                 ? Text('Reservations List Terrain')
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: cubit.equipesdemander.length,
//                     itemBuilder: (context, index) {
//                       final equipe = cubit.equipesdemander[index];
//                       return Card(
//                         elevation: 4,
//                         margin:
//                             EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                         child: ListTile(
//                           leading: Icon(Icons.group),
//                           title: Text(equipe.nom ?? ''),
//                           subtitle: Text(
//                               'Number of Players: ${equipe.numeroJoueurs}'),
//                           trailing: Icon(Icons.arrow_forward),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     EquipeDetailsPage(equipe: equipe),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
