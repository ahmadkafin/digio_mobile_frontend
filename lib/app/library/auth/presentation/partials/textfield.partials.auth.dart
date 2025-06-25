import 'package:flutter/material.dart';
import 'package:myapp/app/library/auth/request/auth.request.dart';

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
    required this.request,
  });
  final Size? deviceSize;
  final String? hint, errMessage;
  final bool? isObscure, isLoading, isGoogleLogin;
  final Function changeObscure;
  final AuthRequest request;

  @override
  Widget build(BuildContext context) {
    double height = 50;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: deviceSize!.width / 1.5,
      height: height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.fromBorderSide(
          BorderSide(
            color: Color.fromRGBO(30, 30, 30, 1),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: TextFormField(
        enabled: !isLoading! ? true : false,
        textInputAction:
            hint! == "Username" ? TextInputAction.next : TextInputAction.go,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          prefixIcon: Icon(
            hint! == "Username" ? Icons.person : Icons.key,
            color: Color.fromARGB(255, 192, 192, 192),
          ),
          suffixIcon: hint != "Password"
              ? null
              : GestureDetector(
                  onTap: () => changeObscure(),
                  child: isObscure!
                      ? Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 192, 192, 192),
                        )
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
            color: Color.fromARGB(255, 192, 192, 192),
            fontSize: 12,
          ),
          focusColor: Colors.black,
          fillColor: Colors.white,
        ),
        obscureText: isObscure!,
        onChanged: (String value) {
          if (hint == 'Username') {
            request.username = value;
          } else {
            request.password = value;
          }
        },
        onSaved: (String? value) {
          if (hint == 'Username') {
            request.username = value!.toLowerCase();
          } else {
            request.password = value!;
          }
        },
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
