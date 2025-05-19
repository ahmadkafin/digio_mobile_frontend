import 'package:flutter/material.dart';
import 'package:myapp/app/library/auth/presentation/widget/form.widget.auth.dart';

class LoginPageAuth extends StatefulWidget {
  const LoginPageAuth({super.key});

  @override
  State<LoginPageAuth> createState() => _LoginPageAuthState();
}

class _LoginPageAuthState extends State<LoginPageAuth> {
  bool isLoading = false;
  bool isObscure = false;
  bool isGoogleLogin = false;
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 30, 30, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Transform.scale(
                  scale: 0.9,
                  child: Image.network(
                    'https://picsum.photos/200/200',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: FormWidgetAuth(
                  deviceSize: deviceSize,
                  isObscure: isObscure,
                  isLoading: isLoading,
                  isGoogleLogin: isGoogleLogin,
                ),
              ),
              Flexible(
                child: Text(
                  "Form Username",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Flexible(
                child: Text(
                  "Form Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
