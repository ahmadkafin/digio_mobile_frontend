import 'package:flutter/material.dart';
import 'package:myapp/app/library/auth/presentation/partials/index.dart'
    as txtField;

class FormWidgetAuth extends StatelessWidget {
  FormWidgetAuth({
    super.key,
    required this.deviceSize,
    required this.isObscure,
    required this.isLoading,
    required this.isGoogleLogin,
  });
  final Size? deviceSize;
  final bool? isObscure, isLoading, isGoogleLogin;
  @override
  txtField.TextField textField = txtField.TextField();

  Widget build(BuildContext context) {
    return Column(
      children: textField.partial(
        deviceSize,
        isObscure,
        isLoading,
        isGoogleLogin,
      ),
    );
  }
}
