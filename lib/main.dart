import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/helper/observer.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/Auth/register_joueur.dart';
import 'package:pfeprojet/screen/joueurScreens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  Widget startWidget = RegisterJour();
  // CachHelper.removdata(key: "TOKEN");
  // TOKEN = await CachHelper.getData(key: 'TOKEN') ?? '';

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
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  const MyApp({super.key, required this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startwidget,
    );
  }
}
