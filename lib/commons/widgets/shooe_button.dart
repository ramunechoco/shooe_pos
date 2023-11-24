import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shooe_pos/commons/colors.dart';
import 'package:shooe_pos/commons/models/button_model.dart';
import 'package:shooe_pos/commons/utils/color_utils.dart';

class ShooeButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color textColor;
  final bool isLoading;
  final Gradient? backgroundGradient;
  final Color? borderColor;

  const ShooeButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.backgroundGradient,
    this.borderColor,
  }) : super(key: key);

  factory ShooeButton.fromModel(ButtonModel model, Function()? onPressed) {
    Color? bgColor = ColorUtils.fromHex(model.backgroundColor ?? "");
    return ShooeButton(
      title: model.title,
      backgroundColor: bgColor,
      backgroundGradient: bgColor == null ? ShooeColor.mainGradient : null,
      textColor: ColorUtils.fromHex(model.textColor ?? "") ?? Colors.white,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      decoration: BoxDecoration(
        gradient: onPressed == null ? null : backgroundGradient,
        borderRadius: BorderRadius.circular(10.0),
        border: borderColor != null
            ? Border.all(
                color: borderColor ?? Colors.white,
                width: 1.0,
              )
            : null,
      ),
      child: ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: backgroundGradient == null
              ? (backgroundColor ?? ShooeColor.darkGrey)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size.fromHeight(36.0),
        ),
        child: isLoading
            ? LoadingAnimationWidget.threeRotatingDots(
                color: Colors.white,
                size: 20.0,
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  color: onPressed != null
                      ? textColor
                      : Colors.black.withOpacity(0.2),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
