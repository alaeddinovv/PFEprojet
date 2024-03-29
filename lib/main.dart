import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/firebase_options.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/helper/observer.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/cubit/annonce_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/Auth/cubit/auth_cubit.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import 'package:pfeprojet/screen/Auth/onboarding.dart';
import 'package:pfeprojet/screen/joueurScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget startWidget = Login();
  // CachHelper.removdata(key: "onbording");
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
          create: ((context) => HomeAdminCubit()..getMyInfo()),
        ),
        BlocProvider(
          create: ((context) => ProfileAdminCubit()),
        ),
        BlocProvider(
          create: ((context) => ProfileCubit()..getMyInfo()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:

            // Onbording(),

            onbordingmain ? startwidget : const Onbording(),
      ),
    );
  }
}
