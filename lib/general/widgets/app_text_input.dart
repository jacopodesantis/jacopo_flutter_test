import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jacopo_flutter_test/general/widgets/app_error_icon.dart';

class AppTextInput extends StatelessWidget {
  final String label;
  final bool _isEmailInput;
  final TextEditingController controller;
  final bool _isError;
  final bool _isPassword;
  final double _margin;
  final bool _isSearch;
  final bool _isNumberInput;
  final bool _isDisabled;
  final Function(String)? onChange;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;

  const AppTextInput({
    required this.label,
    required this.controller,
    bool isError = false,
    bool isEmailInput = false,
    bool isPassword = false,
    bool isSearch = false,
    bool isNumberInput = false,
    double margin = 10,
    bool isDisabled = false,
    this.onChange,
    this.onEditingComplete,
    this.onSubmitted,
    this.maxLength,
    this.maxLengthEnforcement,
    Key? key,
  })  : _isEmailInput = isEmailInput,
        _isError = isError,
        _isPassword = isPassword,
        _margin = margin,
        _isSearch = isSearch,
        _isNumberInput = isNumberInput,
        _isDisabled = isDisabled,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('${label}_input_text'),
      height: 45,
      margin: EdgeInsets.only(top: _margin),
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      decoration: BoxDecoration(
        border: _isError
            ? Border.all(color: Colors.red, style: BorderStyle.solid)
            : null,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: const Color.fromRGBO(73, 87, 113, 1),
      ),
      child: TextField(
        controller: controller,
        readOnly: _isDisabled,
        inputFormatters: _isNumberInput
            ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        style: _isDisabled
            ? TextStyle(color: Theme.of(context).unselectedWidgetColor)
            : null,
        keyboardType: _isEmailInput
            ? TextInputType.emailAddress
            : (_isNumberInput
                ? const TextInputType.numberWithOptions(
                    signed: true,
                  )
                : TextInputType.text),
        obscureText: _isPassword,
        cursorColor: const Color.fromRGBO(165, 187, 210, 1),
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.headline2!.apply(
                color: const Color.fromRGBO(165, 187, 210, 1),
              ),
          label: Row(
            children: [
              if (_isSearch)
                const Icon(
                  Icons.search,
                  color: Color.fromRGBO(165, 187, 210, 1),
                ),
              Text(label)
            ],
          ),
          contentPadding: const EdgeInsets.all(0.0),
          suffixIcon: _isError ? const AppErrorIcon() : null,
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: onChange,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
      ),
    );
  }
}
