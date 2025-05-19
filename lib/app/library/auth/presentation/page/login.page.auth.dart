import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/auth/presentation/partials/textfield.partials.auth.dart';
import 'package:myapp/app/library/auth/presentation/partials/index.dart'
    as txtField;

class LoginPageAuth extends StatefulWidget {
  const LoginPageAuth({super.key});

  @override
  State<LoginPageAuth> createState() => _LoginPageAuthState();
}

class _LoginPageAuthState extends State<LoginPageAuth> {
  bool isLoading = false;
  bool isObscure = false;
  bool isGoogleLogin = false;
  txtField.TextField textField = txtField.TextField();
  String item = "Select Directory";
  List<String> items = [
    "Select Directory",
    "Pertamina",
    "Perusahaan Gas Negara",
    "PGASOL",
    "Google",
  ];

  void changeObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

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
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Transform.scale(
                  scale: 0.6,
                  child: Image.asset(
                    "img/DIGIO_UP.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                width: deviceSize.width / 1.3,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: item,
                    items: items.map((String e) {
                      return DropdownMenuItem(
                        enabled: e == "Select Directory" ? false : true,
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    focusColor: Color.fromRGBO(255, 170, 0, 1),
                    style: TextStyle(),
                    onChanged: (String? value) {
                      setState(() {
                        item = value!;
                      });
                    },
                  ),
                ),
              ),
              ...textField.partial(
                deviceSize,
                isObscure,
                isLoading,
                isGoogleLogin,
                changeObscure,
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 170, 0, 1),
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceSize.width / 3.2,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              GoogleAuthButton(
                onPressed: () {},
                themeMode: ThemeMode.system,
                style: AuthButtonStyle(
                  iconColor: Colors.black,
                  borderRadius: 5,
                  width: deviceSize.width / 1.3,
                  iconSize: 20,
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
