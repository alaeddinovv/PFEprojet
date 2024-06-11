import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/cubit/main_cubit.dart';
import 'package:pfeprojet/screen/JoueurScreens/profile/profile.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';

class HomeJoueur extends StatefulWidget {
  const HomeJoueur({super.key});

  @override
  State<HomeJoueur> createState() => _HomeJoueurState();
}

class _HomeJoueurState extends State<HomeJoueur> {
  late final HomeJoueurCubit homeJoueurCubit;

  @override
  void initState() {
    print('ffffff');
    homeJoueurCubit = HomeJoueurCubit.get(context);
    homeJoueurCubit.getMyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeJoueurCubit, HomeJoueurState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MainCubit.get(context).locale == Locale('en')
                  ? Text(HomeJoueurCubit.get(context)
                      .title[HomeJoueurCubit.get(context).selectedIndex])
                  : Text(HomeJoueurCubit.get(context)
                      .titleAr[HomeJoueurCubit.get(context).selectedIndex]),
            ),
            actions: [
              state is GetMyInformationLoading
                  ? const Center(child: CircularProgressIndicator())
                  : InkWell(
                      onTap: () {
                        navigatAndReturn(
                            context: context, page: const ProfileJoueur());
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            HomeJoueurCubit.get(context).joueurModel!.photo !=
                                    null
                                ? NetworkImage(HomeJoueurCubit.get(context)
                                    .joueurModel!
                                    .photo!)
                                : const AssetImage('assets/images/football.png')
                                    as ImageProvider<Object>,
                      ),
                    ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: HomeJoueurCubit.get(context)
              .body[HomeJoueurCubit.get(context).selectedIndex],
          bottomNavigationBar: BlocBuilder<HomeJoueurCubit, HomeJoueurState>(
            builder: (context, state) {
              if (state is GetMyInformationLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return navigationBar(context);
              }
            },
          ),
        );
      },
    );
  }

  NavigationBarTheme navigationBar(BuildContext context) {
    return NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(size: 28, color: Colors.white);
            }
            return const IconThemeData(size: 24, color: Colors.white60);
          }),
          indicatorColor: greenConst,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              );
            }
            return const TextStyle(
              fontSize: 14.0,
              color: Colors.white60,
            );
          }),
        ),
        child: NavigationBar(
          backgroundColor: greenConst,
          height: 70,
          selectedIndex: HomeJoueurCubit.get(context).selectedIndex,
          onDestinationSelected: (index) =>
              {HomeJoueurCubit.get(context).changeIndexNavBar(index)},
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: S.of(context).fields),
            NavigationDestination(
                icon: Icon(Icons.more_time_rounded, color: Colors.white),
                label: S.of(context).requests),
            NavigationDestination(
                icon: Icon(Icons.campaign, color: Colors.white),
                label: S.of(context).announcements),
            NavigationDestination(
                icon: Icon(Icons.groups_2, color: Colors.white),
                label: S.of(context).teams),
          ],
        ));
  }
}
