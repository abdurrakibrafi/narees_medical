import 'package:flutter/material.dart';

class TreatmentTypeSelector extends StatefulWidget {
  final List<TreatmentType> options;
  final ValueChanged<List<TreatmentType>> onChanged;

  const TreatmentTypeSelector({
    Key? key,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TreatmentTypeSelector> createState() => _TreatmentTypeSelectorState();
}

class _TreatmentTypeSelectorState extends State<TreatmentTypeSelector> {
  final TextEditingController _otherController = TextEditingController();
  bool showOtherField = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Treatment Type", style: TextStyle(fontWeight: FontWeight.bold)),
        ...widget.options.map((option) {
          return CheckboxListTile(
            title: Text(option.name),
            value: option.isSelected,
            onChanged: (value) {
              setState(() {
                option.isSelected = value ?? false;
                if (option.name == "Others") {
                  showOtherField = option.isSelected;
                }
              });
              widget.onChanged(widget.options);
            },
            controlAffinity: ListTileControlAffinity.leading,
          );
        }).toList(),
        if (showOtherField)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: _otherController,
              decoration: InputDecoration(
                hintText: 'Enter Your Treatment Type',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // You can call widget.onChanged here as well if you want to return custom "other" text
              },
            ),
          )
      ],
    );
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }
}


class TreatmentType {
  final String name;
  bool isSelected;

  TreatmentType({required this.name, this.isSelected = false});
}
