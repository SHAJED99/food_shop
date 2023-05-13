import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final String hintText;
  final String obscuringCharacter;
  final double? height;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final bool autofocus;
  final Widget? label;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Color? fillColor;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Iterable<String>? autofillHints;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final BorderRadius? borderRadius;
  final TextAlign textAlign;
  final Color? cursorColor;
  final Function(String? value)? validator;
  final void Function(String? value)? onComplete;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final TextCapitalization textCapitalization;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final String? initialValue;
  final TextStyle? labelStyle;
  const CustomTextFormField({
    Key? key,
    this.height = 48,
    this.autofillHints,
    this.contentPadding,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.hintText = "",
    this.textEditingController,
    this.onComplete,
    this.onChanged,
    this.borderRadius,
    this.onTap,
    this.enabled = true,
    this.style,
    this.errorStyle,
    this.hintStyle,
    this.obscureText = false,
    this.cursorColor,
    this.readOnly = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.obscuringCharacter = "•",
    this.textAlign = TextAlign.start,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.label,
    this.labelText,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.prefixIcon,
    this.prefix,
    this.fillColor,
    this.initialValue,
    this.labelStyle,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController textEditingController;
  late String hintText;
  late BorderRadius borderRadius;
  bool error = false;

  @override
  void initState() {
    super.initState();
    textEditingController = widget.textEditingController ?? TextEditingController();
    hintText = widget.hintText;
    borderRadius = widget.borderRadius ?? BorderRadius.circular(8);
    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        textEditingController.text = widget.initialValue!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        textCapitalization: widget.textCapitalization,
        keyboardType: widget.keyboardType,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,
        autofocus: widget.autofocus,
        autocorrect: widget.autocorrect,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        cursorColor: widget.cursorColor,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        controller: textEditingController,
        autofillHints: widget.autofillHints,
        style: widget.style ?? TextStyle(color: Theme.of(context).primaryColor),
        onEditingComplete: () {
          if (widget.onComplete != null) widget.onComplete!(textEditingController.text);
        },
        onChanged: (value) {
          if (widget.onChanged != null) widget.onChanged!(value);
          if (error) {
            hintText = widget.hintText;
            error = false;
          }
          if (mounted) setState(() {});
        },
        onTap: () {
          if (widget.onTap != null) widget.onTap!();
          if (error) {
            hintText = widget.hintText;
            error = false;
          }
          if (mounted) setState(() {});
        },
        validator: (value) {
          if (widget.validator == null || widget.validator!(value) == null) return null;
          error = true;
          textEditingController.clear();
          hintText = widget.validator!(value);
          if (mounted) setState(() {});
          return "";
        },
        decoration: InputDecoration(
          labelStyle: widget.labelStyle,
          label: widget.label,
          labelText: widget.labelText,
          floatingLabelBehavior: widget.floatingLabelBehavior,
          hintText: hintText,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          filled: widget.fillColor == null ? false : true,
          fillColor: widget.fillColor,
          hintStyle: widget.hintStyle ?? TextStyle(color: error ? Theme.of(context).colorScheme.error : Theme.of(context).primaryColor),
          errorStyle: widget.errorStyle ?? const TextStyle(height: 0),
          contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          enabledBorder: widget.enabledBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
              ),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColorDark),
              ),
          errorBorder: widget.errorBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.error),
              ),
          focusedErrorBorder: widget.focusedErrorBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColorDark),
              ),
          disabledBorder: widget.disabledBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColorLight),
              ),
        ),
      ),
    );
  }
}
