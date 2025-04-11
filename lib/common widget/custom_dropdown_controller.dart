import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdown({
    required this.initialValue,
    required this.items,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.bgColor),
      ),
      child: DropdownButton<String>(

        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 2,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value, // Ensure each value is unique
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
