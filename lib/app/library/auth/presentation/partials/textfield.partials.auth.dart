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
  });
  final Size? deviceSize;
  final String? hint, errMessage;
  final bool? isObscure, isLoading, isGoogleLogin;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      child: Column(children: [
          
        ],
      ),
    );
  }
}
