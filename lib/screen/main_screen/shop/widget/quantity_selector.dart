import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class QuantitySelector extends StatefulWidget {
  final int maxVal;
  final int selectedVal;
  final int minVal;

  const QuantitySelector({Key? key, required this.maxVal, required this.selectedVal,
  required this.minVal}) : super(key: key);

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int selectedVal = 0;

 @override
  void initState() {
   selectedVal = widget.selectedVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Quantity"),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: NumberPicker(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.0)),
            selectedTextStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            value: selectedVal,
            minValue: widget.minVal,

            maxValue: widget.maxVal,
            onChanged: (value) {
              setState(() {
                selectedVal = value;
              });
            }),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, selectedVal);
          },
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
