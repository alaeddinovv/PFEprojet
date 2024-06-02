import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';

import 'package:pfeprojet/screen/JoueurScreens/profile/profile.dart';

import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
// import 'cubit/home_joueur_cubit.dart';

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
            title: const Text('HomeJoueur'),
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
          bottomNavigationBar: navigationBar(context),
        );
      },
    );
  }

  NavigationBarTheme navigationBar(BuildContext context) {
    return NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFF00FFCC),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        child: NavigationBar(
          // backgroundColor: Colors.white,
          height: 70,
          selectedIndex: HomeJoueurCubit.get(context).selectedIndex,
          onDestinationSelected: (index) =>
              {HomeJoueurCubit.get(context).changeIndexNavBar(index)},
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'terrain'),
            NavigationDestination(
                icon: Icon(Icons.more_time_rounded), label: 'Reservation'),
            NavigationDestination(icon: Icon(Icons.campaign), label: 'annonce'),
            NavigationDestination(icon: Icon(Icons.groups_2), label: 'equipe'),
          ],
        ));
  }
}
