import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/details.dart';

class Annonce extends StatelessWidget {
  const Annonce({super.key});

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed functionality here
        },
        child: Icon(Icons.add),
      ),

    );

  }


  Container terrainItem({required context}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Simple Text',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Text(
                'Bold Text',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            height: 200, // Adjust as needed
            child: SingleChildScrollView(
              child: Text(
                'Rest of the content here...',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



