import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolTipWidget extends ConsumerWidget {
  final String text;
  final VoidCallback onTap;
  final Color backGroundColor;
  final Color textColor;
  const ToolTipWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.backGroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 40,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backGroundColor,
          ),
          child: Center(
            child: Text(text, style: TextStyle(color: textColor)),
          ),
        ),
      ),
    );
  }
}
