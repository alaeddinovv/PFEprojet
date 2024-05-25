import 'package:flutter/material.dart';
import 'package:pfeprojet/Api/wilayadefine.dart';

class DropdownScreen extends StatefulWidget {
  final TextEditingController selectedWilaya;
  final TextEditingController selectedDaira;

  const DropdownScreen(
      {super.key, required this.selectedWilaya, required this.selectedDaira});
  @override
  _DropdownScreenState createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  String? selectedWilaya;
  String? selectedDaira;
  List<String> dairas = [];

  @override
  void initState() {
    selectedWilaya =
        widget.selectedWilaya.text.isEmpty ? null : widget.selectedWilaya.text;

    if (selectedWilaya != null) {
      updateDairas(selectedWilaya);
    }

    selectedDaira =
        widget.selectedDaira.text.isEmpty ? null : widget.selectedDaira.text;

    super.initState();
  }

  void updateDairas(String? wilaya) {
    if (wilaya == null) {
      setState(() {
        dairas = [];
        selectedDaira = null;
        widget.selectedDaira.text = "";
      });
      return;
    }

    var filteredDairas = algeriaCities
        .where((city) => city['wilaya_name_ascii'] == wilaya.split(" - ")[1])
        .map((city) => city['daira_name_ascii'] as String)
        .toSet()
        .toList();

    setState(() {
      dairas = filteredDairas;
      selectedDaira = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var wilayas = algeriaCities
        .map((city) => "${city['wilaya_code']} - ${city['wilaya_name_ascii']}")
        .toSet()
        .toList();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedWilaya,
                onChanged: (value) {
                  setState(() {
                    selectedWilaya = value;
                    // widget.selectedWilaya.text = value!.split(' - ')[1];
                    widget.selectedWilaya.text = value!;
                    widget.selectedDaira.text = "";
                    updateDairas(value);
                  });
                },
                items: wilayas.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('Select Wilaya'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedDaira,
                onChanged: (value) {
                  setState(() {
                    selectedDaira = value;
                    widget.selectedDaira.text = value!;
                  });
                },
                items: dairas.isNotEmpty
                    ? dairas.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : [],
                hint: const Text('Select Daira'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
