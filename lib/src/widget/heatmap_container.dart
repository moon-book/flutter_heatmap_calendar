import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/src/data/typedefs.dart';
import '../data/heatmap_color.dart';

class HeatMapContainer extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final bool? showText;
  final void Function(DateTime dateTime, [TapUpDetails? tapUpDetails])? onClick;
  final OnEnterDateCallback? onEnter;
  final OnHoverDateCallback? onHover;

  const HeatMapContainer({
    Key? key,
    required this.date,
    this.margin,
    this.size,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.onClick,
    this.onEnter,
    this.onHover,
    this.showText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          onEnter?.call(date, event.position);
        },
        onHover: (event) {
          onHover?.call(date, event.position);
        },
        onExit: (event) {
          onHover?.call(null, event.position);
        },
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? HeatMapColor.defaultColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutQuad,
              width: size,
              height: size,
              alignment: Alignment.center,
              child: (showText ?? true)
                  ? Text(
                      date.day.toString(),
                      style: TextStyle(color: textColor ?? const Color(0xFF8A8A8A), fontSize: fontSize),
                    )
                  : null,
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
              ),
            ),
          ),
          // onTap: () {
          //   onClick != null ? onClick!(date) : null;
          // },
          onTapUp: (details) {
            onClick != null ? onClick!(date, details) : null;
          },
        ),
      ),
    );
  }
}
