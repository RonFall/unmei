import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool hasHideText;
  final bool showTopText;
  final bool next;
  final String hint;
  final String topText;
  final Color textColor;
  final Color fieldBarColor;
  final TextInputAction fieldAction;
  final ValueChanged<String>? onType;
  final GestureTapCallback? onClear;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.next = false,
    this.hasHideText = false,
    this.showTopText = false,
    this.topText = '',
    this.hint = '',
    this.textColor = Colors.black,
    this.fieldBarColor = Colors.blue,
    this.fieldAction = TextInputAction.done,
    this.onType,
    this.onClear = null,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController controller;
  late bool isHide;

  @override
  void initState() {
    controller = widget.controller;
    isHide = widget.hasHideText;
    super.initState();
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
          if (widget.showTopText) Text(widget.topText, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          GestureDetector(
            onDoubleTap: () {
              if (widget.hasHideText) setState(() => isHide = !isHide);
            },
            child: Theme(
              data: ThemeData(colorScheme: ThemeData().colorScheme.copyWith(primary: widget.fieldBarColor)),
              child: TextFormField(
                controller: controller,
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
                    borderSide: BorderSide(color: widget.fieldBarColor, width: 1),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  fillColor: const Color(0xFFF4F4F4),
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.clear();
                      if (widget.onClear != null) widget.onClear!();
                    },
                    child: const Tooltip(message: 'Стереть', child: Icon(Icons.cancel_outlined)),
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
