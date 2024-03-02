import 'package:flutter/material.dart';

Widget defaultForm(
        {controller,
        int maxline = 1,
        Widget? suffix,
        required context,
        String? sufixText,
        required TextInputType type,
        required Function valid,
        Text? lable,
        Icon? prefixIcon,
        IconButton? sufixIcon,
        TextInputAction? textInputAction,
        bool obscureText = false,
        String? valeurinitial,
        Function? onFieldSubmitted}) =>
    TextFormField(
      initialValue: valeurinitial,
      textInputAction: textInputAction,
      onFieldSubmitted: (k) {
        onFieldSubmitted!();
      },
      validator: (String? value) {
        return valid(value);
      },
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          label: lable,
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          suffix: suffix,
          suffixText: sufixText),
      controller: controller,
      maxLines: maxline,
      keyboardType: type,
      obscureText: obscureText,
    );

void changepage(context, Widget ala) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => ala), (route) => false);
