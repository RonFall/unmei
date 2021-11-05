import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String hint;
  final bool next;
  final TextEditingController controller;
  final TextInputAction fieldAction;
  final Color textColor;
  final Color fieldBarColor;

  TextFieldWidget({
    required this.controller,
    this.next = false,
    this.fieldAction = TextInputAction.done,
    this.hint = '',
    this.textColor = Colors.black,
    this.fieldBarColor = Colors.red,
  });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController controller;
  late FocusNode fieldNode;
  late bool hasTapped;

  @override
  void initState() {
    controller = widget.controller;
    fieldNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    fieldNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        focusNode: fieldNode,
        textInputAction: widget.fieldAction,
        style: TextStyle(color: widget.textColor),
        cursorColor: widget.fieldBarColor,
        decoration: InputDecoration(
          hintText: widget.hint,
          contentPadding: const EdgeInsets.only(left: 16),
          focusColor: widget.fieldBarColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              color: widget.fieldBarColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          fillColor: const Color(0xFFF4F4F4),
          filled: true,
          suffixIcon: GestureDetector(
            onTap: () => controller.clear(),
            child: Tooltip(
              message: 'Стереть',
              child: Icon(
                Icons.cancel_outlined,
                color: fieldNode.hasFocus
                    ? widget.fieldBarColor
                    : Theme.of(context).disabledColor,
              ),
            ),
          ),
        ),
        onEditingComplete: () {
          if (widget.next) FocusScope.of(context).nextFocus();
          else FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
