import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/details.dart';

class Terrains extends StatelessWidget {
  const Terrains({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, int index) => terrainItem(context: context),
            separatorBuilder: (context, int index) => const SizedBox(
                  height: 16,
                ),
            itemCount: 4),
      ),
    );
  }

  InkWell terrainItem({required context}) {
    return InkWell(
      onTap: () {
        navigatAndReturn(context: context, page: TerrainDetailsScreen());
      },
      child: const Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('assets/images/terrain2.jpg'),
              height: 180,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                height: 90,
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Zwaghi constantine 1100',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.groups),
                        SizedBox(
                          width: 5,
                        ),
                        Text('6 Joueurs')
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(Icons.price_check),
                        SizedBox(
                          width: 5,
                        ),
                        Text('500 Da/H')
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
