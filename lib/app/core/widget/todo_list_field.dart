import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  TodoListField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator
  }) :
        assert(obscureText == true ? suffixIconButton == null : true),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_,obscureTextValue, __){
        return TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.red)
              ),
              isDense: true,
              suffixIcon: suffixIconButton ??
                  (obscureText == true
                      ? IconButton(
                    icon: obscureTextValue
                        ? const Icon(Icons.visibility, size: 19,)
                        : const Icon(Icons.visibility_off, size: 19,),
                    onPressed: () {
                      obscureTextVN.value = !obscureTextValue;
                    },
                  )
                      : null)
          ),
          obscureText: obscureTextValue,
        );
      },

    );
  }
}
