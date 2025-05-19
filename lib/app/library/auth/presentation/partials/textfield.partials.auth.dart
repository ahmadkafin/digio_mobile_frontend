import 'package:flutter/material.dart';

class TextFieldPartial extends StatelessWidget {
  const TextFieldPartial({
    super.key,
    required this.deviceSize,
    required this.hint,
    required this.errMessage,
    required this.isObscure,
    required this.isLoading,
    required this.isGoogleLogin,
    required this.changeObscure,
  });
  final Size? deviceSize;
  final String? hint, errMessage;
  final bool? isObscure, isLoading, isGoogleLogin;
  final Function changeObscure;

  @override
  Widget build(BuildContext context) {
    double height = 50;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: deviceSize!.width / 1.3,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: TextFormField(
        enabled: !isLoading! ? true : false,
        textInputAction:
            hint! == "Username" ? TextInputAction.next : TextInputAction.go,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          prefixIcon: Icon(
            hint! == "Username" ? Icons.person : Icons.key,
          ),
          suffixIcon: hint != "Password"
              ? null
              : GestureDetector(
                  onTap: () => changeObscure(),
                  child: isObscure!
                      ? Icon(Icons.visibility)
                      : Icon(
                          Icons.visibility_off,
                          color: Color.fromRGBO(255, 170, 0, 1),
                        ),
                ),
          isDense: true,
          isCollapsed: false,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
          focusColor: Colors.black,
        ),
        obscureText: isObscure!,
        validator: (value) {
          if (!isGoogleLogin!) {
            if (value!.isEmpty) {
              return errMessage;
            }
            return null;
          }
          return value;
        },
      ),
    );
  }
}
