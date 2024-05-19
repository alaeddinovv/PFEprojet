import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pfeprojet/Api/socket_io.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/cubit/main_cubit.dart';
import 'package:pfeprojet/fcm-firebase.dart';
import 'package:pfeprojet/firebase_options.dart';
import 'package:pfeprojet/generated/l10n.dart';
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
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pfeprojet/screen/joueurScreens/reservation/cubit/reservation_cubit.dart';
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
  String deviceInfo = await CachHelper.getData(key: 'deviceInfo') ??
      await getDeviceIdentifier();
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
  SocketService().initSocket();

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
          create: ((context) => MainCubit()),
        ),
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
          create: ((context) => EquipeCubit()..getMyEquipe()),
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
        BlocProvider(
          create: ((context) => ReservationJoueurCubit()),
        ),
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            locale: MainCubit.get(context).locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home:

                // Onbording(),

                onbordingmain ? startwidget : const Onbording(),
          );
        },
      ),
    );
  }
}
