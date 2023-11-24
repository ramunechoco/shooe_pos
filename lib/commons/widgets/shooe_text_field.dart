import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shooe_pos/commons/colors.dart';

enum ShooeTextFieldTheme {
  dark,
  light,
}

class ShooeTextField extends StatefulWidget {
  final String? title;
  final String placeholder;
  final String? errorMessage;
  final bool isSecureText;
  final Function(String value) onValueChanged;
  final TextInputType? textInput;
  final ShooeTextFieldTheme theme;
  final List<TextInputFormatter>? inputFormatter;
  final bool isFixErrorStateHeight;
  final Widget? trailing;
  final bool isEnabled;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;
  final bool autoFocus;
  final int? minLines;
  final int? maxLines;
  final double? height;
  final bool isMandatory;

  const ShooeTextField({
    Key? key,
    this.title,
    required this.placeholder,
    this.errorMessage,
    this.isSecureText = false,
    required this.onValueChanged,
    this.textInput,
    this.theme = ShooeTextFieldTheme.dark,
    this.inputFormatter,
    this.isFixErrorStateHeight = true,
    this.trailing,
    this.isEnabled = true,
    this.textColor,
    this.fontWeight,
    this.controller,
    this.autofillHints,
    this.autoFocus = false,
    this.minLines,
    this.maxLines,
    this.height,
    this.isMandatory = false,
  }) : super(key: key);

  @override
  State<ShooeTextField> createState() => _ShooeTextFieldState();
}

class _ShooeTextFieldState extends State<ShooeTextField> {
  bool isOnSecureMode = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title ?? "",
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: ShooeColor.darkGrey,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: ShooeColor.darkGrey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: widget.height == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      autofocus: widget.autoFocus,
                      minLines: widget.minLines,
                      validator: (value) {
                        if (widget.isMandatory &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      maxLines: widget.maxLines ?? 1,
                      controller: widget.controller,
                      enabled: widget.isEnabled,
                      inputFormatters: widget.inputFormatter,
                      keyboardType: widget.textInput,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      obscureText: widget.isSecureText && isOnSecureMode,
                      scrollPadding: EdgeInsets.zero,
                      autofillHints: widget.autofillHints,
                      onChanged: widget.onValueChanged,
                      style: TextStyle(
                        color: ShooeColor.darkGrey,
                        fontSize: 15.0,
                        fontWeight: widget.fontWeight,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: widget.height == null
                            ? const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 12.0)
                            : const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                        border: InputBorder.none,
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  if (widget.isSecureText)
                    InkWell(
                      onTap: () {
                        setState(() {
                          isOnSecureMode = !isOnSecureMode;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: Icon(
                          isOnSecureMode
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (widget.trailing != null) widget.trailing ?? Container(),
                ],
              ),
            ],
          ),
        ),
        if (!(!widget.isFixErrorStateHeight &&
            (widget.errorMessage ?? "").isEmpty))
          Container(
            padding: const EdgeInsets.only(top: 4.0),
            height: widget.isFixErrorStateHeight ? 20.0 : null,
            child: Text(
              widget.errorMessage ?? "",
              style: const TextStyle(color: ShooeColor.red, fontSize: 8.0),
            ),
          ),
      ],
    );
  }
}
