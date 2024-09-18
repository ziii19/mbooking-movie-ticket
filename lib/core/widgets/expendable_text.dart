import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mbooking/core/theme/app_colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({
    super.key,
    required this.text,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const int maxChars = 200;

        final displayText = isExpanded
            ? widget.text
            : widget.text.length > maxChars
                ? widget.text.substring(0, maxChars)
                : widget.text;

        return RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.white,
                ),
            children: [
              TextSpan(
                text: displayText,
              ),
              if (widget.text.length > maxChars && !isExpanded)
                const TextSpan(
                  text: '... ',
                ),
              if (widget.text.length > maxChars)
                TextSpan(
                  text: isExpanded ? 'See less' : 'See more',
                  style: const TextStyle(color: AppColors.yellow),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                ),
            ],
          ),
        );
      },
    );
  }
}
