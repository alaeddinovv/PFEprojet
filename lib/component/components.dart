import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

void navigatAndReturn({required context, required page}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

void navigatAndFinish({required context, required page}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);

Container buttonSubmit(
    {required BuildContext context,
    required Function onPressed,
    required String text}) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(15)),
    ),
    child: Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        child: MaterialButton(
          highlightColor: Colors.blue,
          splashColor: const Color.fromRGBO(0, 0, 0, 0),
          onPressed: () {
            onPressed();
          },
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
