import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';
import 'package:pfeprojet/generated/l10n.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  late final HomeAdminCubit cubit;
  @override
  void initState() {
    cubit = HomeAdminCubit.get(context);
    cubit.getMyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAdminCubit, HomeAdminState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(HomeAdminCubit.get(context)
                  .title[HomeAdminCubit.get(context).selectedIndex]),
            ),
            actions: [
              state is GetMyInformationLoading
                  ? const Center(child: CircularProgressIndicator())
                  : InkWell(
                      onTap: () {
                        navigatAndReturn(
                            context: context, page: const ProfileAdmin());
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: HomeAdminCubit.get(context)
                                    .adminModel!
                                    .photo !=
                                null
                            ? NetworkImage(
                                HomeAdminCubit.get(context).adminModel!.photo!)
                            : const AssetImage('assets/images/football.png')
                                as ImageProvider<Object>,
                      ),
                    ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: HomeAdminCubit.get(context)
              .body[HomeAdminCubit.get(context).selectedIndex],
          bottomNavigationBar: navigationBar(context),
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
          selectedIndex: HomeAdminCubit.get(context).selectedIndex,
          onDestinationSelected: (index) =>
              {HomeAdminCubit.get(context).changeIndexNavBar(index)},
          destinations: [
            NavigationDestination(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: S.of(context).fields),
            NavigationDestination(
                icon: const Icon(
                  Icons.more_time_rounded,
                  color: Colors.white,
                ),
                label: S.of(context).reservations),
            NavigationDestination(
                icon: const Icon(
                  Icons.campaign,
                  color: Colors.white,
                ),
                label: S.of(context).announcements),
          ],
        ));
  }
}
