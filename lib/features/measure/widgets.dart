import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/format.dart';

final _numFilter = FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]'));

/// Numeric text field. [value] is used only as the initial text.
class NumField extends StatelessWidget {
  const NumField({
    super.key,
    required this.label,
    this.controller,
    this.value,
    this.onChanged,
    this.big = false,
    this.hint,
    this.suffix,
    this.autofocus = false,
  });

  final String label;
  final TextEditingController? controller;
  final double? value;
  final ValueChanged<double?>? onChanged;
  final bool big;
  final String? hint;
  final Widget? suffix;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? numText(value) : null,
      autofocus: autofocus,
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [_numFilter],
      style: big ? Theme.of(context).textTheme.headlineSmall : null,
      decoration: InputDecoration(labelText: label, hintText: hint, suffixIcon: suffix),
      onChanged: onChanged == null ? null : (s) => onChanged!(parseNum(s)),
    );
  }
}

class BigChoice extends StatelessWidget {
  const BigChoice({
    super.key,
    required this.title,
    this.subtitle,
    required this.onPressed,
    this.color,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(14),
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            if (subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
