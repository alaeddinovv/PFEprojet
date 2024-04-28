import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/fcm-firebase.dart';
import 'package:pfeprojet/firebase_options.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/helper/observer.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/cubit/annonce_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/cubit/reservation_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/Auth/cubit/auth_cubit.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import 'package:pfeprojet/screen/Auth/onboarding.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart'
    as terrainjoueur;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget startWidget = Login();
  // CachHelper.removdata(key: "onbording");
  // CachHelper.removdata(key: "TOKEN");

  bool onbordingmain = await CachHelper.getData(key: 'onbording') ?? false;
  TOKEN = await CachHelper.getData(key: 'TOKEN') ?? '';

  if (TOKEN != '') {
    DECODEDTOKEN = JwtDecoder.decode(TOKEN);
    if (DECODEDTOKEN['role'] == 'joueur') {
      startWidget = const HomeJoueur();
    } else if (DECODEDTOKEN['role'] == 'admin') {
      startWidget = const HomeAdmin();
    }
  }
  await FirebaseApi().initNotifications();

  runApp(MyApp(
    startwidget: startWidget,
    onbordingmain: onbordingmain,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  final bool onbordingmain;

  const MyApp(
      {super.key, required this.startwidget, required this.onbordingmain});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => AuthCubit()),
        ),
        BlocProvider(
          create: ((context) => TerrainCubit()..getMyTerrains()),
        ),
        BlocProvider(
          create: ((context) => AnnonceCubit()..getMyAnnonce()),
        ),
        BlocProvider(
          create: ((context) => AnnonceJoueurCubit()..getMyAnnonceJoueur()),
        ),
        BlocProvider(
          create: ((context) => HomeAdminCubit()..getMyInfo()),
        ),
        BlocProvider(
          create: ((context) => HomeJoueurCubit()..getMyInfo()),
        ),
        BlocProvider(
          create: ((context) => ProfileAdminCubit()),
        ),
        BlocProvider(
          create: ((context) => ProfileJoueurCubit()),
        ),
        BlocProvider(
          create: ((context) => terrainjoueur.TerrainCubit()..getMyTerrains()),
        ),
        BlocProvider(
          create: ((context) => ReservationCubit()..fetchReservations()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home:

            // Onbording(),

            onbordingmain ? startwidget : const Onbording(),
      ),
    );
  }
}
