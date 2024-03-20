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
TextFormField defaultForm3(
    {controller,
    int maxline = 1,
    Widget? suffix,
    Widget? prifix,
    required context,
    String? sufixText,
    required TextInputType type,
    required Function valid,
    Text? lable,
    String? labelText,
    Icon? prefixIcon,
    Widget? sufixIcon,
    TextInputAction? textInputAction,
    bool obscureText = false,
    bool readOnly = false,
    bool enabled = true,
    String? valeurinitial,
    Function? onFieldSubmitted}) {
  return TextFormField(
    enabled: enabled,
    readOnly: readOnly,
    initialValue: valeurinitial,
    textInputAction: textInputAction,
    onFieldSubmitted: (k) {
      onFieldSubmitted!();
    },
    validator: (String? value) {
      return valid(value);
    },
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: lable,
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        prefix: prifix,
        suffix: suffix,
        suffixText: sufixText,
        labelText: labelText),
    controller: controller,
    maxLines: maxline,
    keyboardType: type,
    obscureText: obscureText,
  );
}

Widget defaultForm2(
        {required TextEditingController controller,
        bool obscureText = false,
        bool readOnly = false,
        required TextInputAction textInputAction,
        Widget? suffixIcon,
        Widget? suffix,
        Icon? prefixIcon,
        String? label,
        String? hintText,
        int? maxLength,
        int maxLines = 1,
        TextInputType? type,
        required Function? validator,
        Function()? onTap,
        Function(dynamic)? onFieldSubmitted}) =>
    TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          suffix: suffix,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
          labelText: label),
      controller: controller,
      validator: (String? value) {
        if (value!.isEmpty) {
          return validator!(value);
        }
        return null;
      },
    );

SizedBox defaultSubmit({
  required Function valid,
  required String text,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          // textStyle: const TextStyle(fontSize: 19),
          backgroundColor: Colors.blueAccent),
      onPressed: () {
        valid();
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

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

Widget defaultSubmit1(
        {formKey,
        Function()? onPressed,
        bool isothericon = false,
        Color background = Colors.blue,
        Widget? icon}) =>
    FloatingActionButton(
      backgroundColor: background,
      // onPressed: () {
      //   if (formKey.currentState!.validate()) {}
      // },
      onPressed: onPressed,
      child: !isothericon ? const Icon(Icons.arrow_forward_ios) : icon,
    );
Widget defaultSubmit2({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  Function()? onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

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

PreferredSizeWidget defaultAppBar(
        {
        // String? title,
        List<Widget>? actions,
        bool canreturn = true,
        Widget? title,
        Widget? leading,
        // Function()? whenBack,
        Function()? onPressed}) =>
    AppBar(
        titleSpacing: 0,
        leading: canreturn
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))
            : leading,
        title: title,
        actions: actions);
