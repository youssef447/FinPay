import 'package:finpay/core/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? sufix;
  final Widget? prefix;
  final bool?enabled;
  final bool obscure;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? limit;
  final TextCapitalization? capitalization;
  final TextInputType? inputType;
  final bool? readOnly;
  final bool? autoValidate;
  final Color? fillColor;
  final TextStyle? hintStyle;
    final TextStyle? style;

  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    this.hintStyle,
    required this.hintText,
    this.contentPadding,
    required this.textEditingController,
    this.sufix,
    this.enabled,
    this.prefix,
    this.obscure = false,
    this.limit,
    this.labelText,
    this.capitalization,
    this.inputType,
    this.readOnly = false,
    this.focusNode,
    this.fillColor,
    this.validator,
    this.autoValidate, this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      autovalidateMode:
          autoValidate ?? false ? AutovalidateMode.onUserInteraction : null,
      obscureText: obscure,
      enabled: enabled,
      focusNode: focusNode,
      textCapitalization: capitalization ?? TextCapitalization.none,
      keyboardType: inputType,
      readOnly: readOnly!,
      inputFormatters: limit,
     style: style?? Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        filled: true,
        fillColor: fillColor ?? (AppTheme.isLightTheme == false
            ? const Color(0xff211F32)
            : const Color(0xffF9F9FA)) ,
        prefixIcon: prefix,
        suffixIcon: sufix,
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintStyle?? Theme.of(context).textTheme.bodySmall,
      
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16)),
      ),
      validator: validator,
    );
  }
}
