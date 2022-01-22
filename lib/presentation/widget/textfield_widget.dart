import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool hasHideText;
  final bool showTopText;
  final bool next;
  final String hint;
  final String topText;
  final Color textColor;
  final Color hintTextColor;
  final Color fieldBarColor;
  final Color fillColor;
  final TextInputAction fieldAction;
  final Widget? prefixIcon;
  final ValueChanged<String>? onType;
  final GestureTapCallback? onClear;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.next = false,
    this.hasHideText = false,
    this.showTopText = false,
    this.topText = '',
    this.hint = '',
    this.textColor = Colors.black,
    this.hintTextColor = Colors.grey,
    this.fieldBarColor = Colors.blue,
    this.fillColor = const Color(0xFFF4F4F4),
    this.fieldAction = TextInputAction.done,
    this.prefixIcon,
    this.onType,
    this.onClear,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController controller;
  late bool isHide;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    isHide = widget.hasHideText;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showTopText)
            Text(widget.topText, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          GestureDetector(
            onDoubleTap: () {
              if (widget.hasHideText) setState(() => isHide = !isHide);
            },
            child: Theme(
              data: ThemeData(
                colorScheme: ThemeData().colorScheme.copyWith(
                      primary: widget.fieldBarColor,
                    ),
              ),
              child: TextFormField(
                controller: controller,
                keyboardType: widget.keyboardType,
                textInputAction: widget.fieldAction,
                style: TextStyle(color: widget.textColor),
                cursorColor: widget.fieldBarColor,
                obscureText: isHide,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  contentPadding: const EdgeInsets.only(left: 16),
                  focusColor: widget.fieldBarColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: widget.fieldBarColor,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fillColor: widget.fillColor,
                  hintStyle: TextStyle(color: widget.hintTextColor),
                  filled: true,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.clear();
                      if (widget.onClear != null) widget.onClear!();
                    },
                    child: const Tooltip(
                      message: 'Стереть',
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ),
                ),
                onChanged: widget.onType,
                onEditingComplete: () {
                  if (widget.next) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
