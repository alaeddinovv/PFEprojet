import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfeprojet/design_login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../helper/cachhelper.dart';

class OnbordingModel {
  final String img;
  final String title;
  final String body;

  OnbordingModel(this.img, this.title, this.body);
}

class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  Icon nextIcon = const Icon(
    Icons.arrow_forward_ios,
    color: Colors.white,
  );
  void gotologin() {
    CachHelper.putcache(key: 'onbording', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginDesign()),
            (route) => false);
      }
    });
  }

  bool islast = false;
  var onbordingController = PageController();
  List<OnbordingModel> models = [
    OnbordingModel('assets/images/final2.png', 'Acheter ou louer ',
        'Acheter ou louez votre maison attendue depuis chez vous'),
    OnbordingModel('assets/images/reservation.png', 'Trouver la ',
        'Trouver votre maison depuis carte géographique'),
    OnbordingModel('assets/images/rencontre.png', 'Inscrivez-vous',
        'Connectez-vous pour voir nos offres exceptionnelles'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  gotologin();
                },
                child: const Text(
                  'SKIP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == models.length - 1) {
                      islast = true;

                      setState(() {
                        nextIcon = const Icon(Icons.done, color: Colors.white);
                      });
                    } else {
                      islast = false;

                      setState(() {
                        nextIcon = const Icon(Icons.arrow_forward_ios,
                            color: Colors.white);
                      });
                    }
                  },
                  controller: onbordingController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => itemView(models[index]),
                  itemCount: 3,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: onbordingController,
                      count: models.length,
                      effect: const ExpandingDotsEffect(
                          dotWidth: 20,
                          dotHeight: 15,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.blueAccent),
                      onDotClicked: (index) {}),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.blueAccent,
                    onPressed: () {
                      onbordingController.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.fastOutSlowIn);
                      if (islast == true) {
                        gotologin();
                      }
                    },
                    child: nextIcon,
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }

  Widget itemView(OnbordingModel k) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${k.img}'),
          )),
          const SizedBox(height: 20),
          Text(
            '${k.title}',
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          const SizedBox(height: 20),
          Text(
            '${k.body}',
            style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          const SizedBox(height: 40),
        ],
      );
}
