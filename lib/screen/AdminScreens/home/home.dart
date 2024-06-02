import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  late final HomeAdminCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
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
            title: Text(HomeAdminCubit.get(context)
                .title[HomeAdminCubit.get(context).selectedIndex]),
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
          indicatorColor: Colors.blue[100],
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: HomeAdminCubit.get(context).selectedIndex,
          onDestinationSelected: (index) =>
              {HomeAdminCubit.get(context).changeIndexNavBar(index)},
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.more_time_rounded), label: 'Reservation'),
            NavigationDestination(icon: Icon(Icons.add), label: 'Annonce'),
            NavigationDestination(icon: Icon(Icons.groups_2), label: 'tournoi'),
          ],
        ));
  }
}
