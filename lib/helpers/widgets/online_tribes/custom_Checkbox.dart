import '../../../helpers/main_constants.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({required this.callBack, required this.isChecked});
  Function callBack;
  bool isChecked;
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isChecked = !widget.isChecked;
          widget.callBack( widget.isChecked);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isChecked ? kColorBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border:
              widget.isChecked ? null : Border.all(color: kTextColorGrey, width: 1.5),
        ),
        width: 20,
        height: 20,
        child: widget.isChecked
            ? Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
