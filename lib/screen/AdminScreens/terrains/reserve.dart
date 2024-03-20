import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';

class Reserve extends StatelessWidget {
  Reserve({super.key, required this.index});
  final index;
  final userIdController = TextEditingController();
  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final dureeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isOuiChecked = false;
    bool isNonChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('User Id: ', style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 8,
              ),
              defaultForm3(
                sufixIcon:
                    TextButton(onPressed: () {}, child: const Text('Check')),
                prefixIcon: const Icon(Icons.person_outline),
                context: context,
                type: TextInputType.number,
                valid: () {},
                labelText: 'User Id',
                controller: userIdController,
              ),
              const Visibility(
                  visible: false,
                  child: Row(
                    children: [
                      Text('houssemeddine'),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              const Text("Date de debut:", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 250,
                child: defaultForm3(
                  enabled: false,
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  context: context,
                  readOnly: true,
                  type: TextInputType.datetime,
                  valid: () {},
                  labelText:
                      "${TerrainCubit.get(context).dateSelected.toLocal()}"
                          .split(' ')[0],
                  controller: dateController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Hour de debut:", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 250,
                child: defaultForm3(
                  enabled: false,
                  prefixIcon: const Icon(Icons.timer_outlined),
                  context: context,
                  readOnly: true,
                  type: TextInputType.number,
                  valid: () {},
                  labelText: TerrainCubit.get(context).timeSlots[index]['time'],
                  controller: hourController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Duree (en Semaine): ',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              defaultForm3(
                prefixIcon: const Icon(Icons.timer_outlined),
                context: context,
                type: TextInputType.number,
                valid: () {},
                labelText: 'Duree',
                controller: dureeController,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Prix: 0.0', style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Payement: ', style: TextStyle(fontSize: 20)),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isOuiChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isOuiChecked = value!;
                                if (isOuiChecked) isNonChecked = false;
                              });
                            },
                          ),
                          const Text('Oui'),
                          const SizedBox(width: 10),
                          Checkbox(
                            value: isNonChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isNonChecked = value!;
                                if (isNonChecked) isOuiChecked = false;
                              });
                            },
                          ),
                          const Text('Non'),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blueAccent),
                  onPressed: () {},
                  child: const Text(
                    "Reserver",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
