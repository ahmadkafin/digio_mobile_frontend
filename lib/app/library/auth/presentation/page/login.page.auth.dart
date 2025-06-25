import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/presentation/partials/textfield.partials.auth.dart';
import 'package:myapp/app/library/auth/providers/auth.providers.dart';
import 'package:myapp/app/library/auth/request/auth.request.dart';
import 'package:myapp/core/utils/snackbarMessage.utils.dart';

class LoginPageAuth extends StatefulHookConsumerWidget {
  const LoginPageAuth({super.key});

  @override
  ConsumerState<LoginPageAuth> createState() => _LoginPageAuthState();
}

class _LoginPageAuthState extends ConsumerState<LoginPageAuth> {
  bool isLoading = false;
  bool isObscure = false;
  bool isGoogleLogin = false;
  AuthRequest? request = AuthRequest(
    username: "",
    password: "",
    directory: "",
  );
  String item = "Select Directory";
  List<String> items = [
    "Select Directory",
    "Pertamina",
    "Perusahaan Gas Negara",
    "PGASOL",
  ];

  final _storage = FlutterSecureStorage();

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/bg_first.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(120),
              BlendMode.darken,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoSection(deviceSize),
                _dropDown(deviceSize),
                TextFieldPartial(
                  deviceSize: deviceSize,
                  hint: "Username",
                  errMessage: "Username Cannot be empty",
                  isObscure: false,
                  isLoading: isLoading,
                  isGoogleLogin: isGoogleLogin,
                  changeObscure: changeObscure,
                  request: request!,
                ),
                TextFieldPartial(
                  deviceSize: deviceSize,
                  hint: "Password",
                  errMessage: "Password Cannot be empty",
                  isObscure: !isObscure,
                  isLoading: isLoading,
                  isGoogleLogin: isGoogleLogin,
                  changeObscure: changeObscure,
                  request: request!,
                ),
                isLoading
                    ? Flexible(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Flexible(
                        child: Column(
                          children: [
                            _buildButtonSubmit(deviceSize),
                            _buildButtonGoogle(deviceSize)
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GoogleAuthButton _buildButtonGoogle(Size deviceSize) {
    return GoogleAuthButton(
      onPressed: () {},
      themeMode: ThemeMode.system,
      style: AuthButtonStyle(
        // iconColor: Colors.black,
        borderRadius: 5,
        buttonColor: Color.fromRGBO(30, 30, 30, 1),
        width: deviceSize.width / 1.5,
        iconSize: 20,
        textStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Flexible _buildButtonSubmit(Size deviceSize) {
    return Flexible(
      child: ElevatedButton(
        onPressed: () async {
          request!.directory = item.toLowerCase();
          setState(() {
            isLoading = true;
          });
          ref.read(authProvider.notifier).login(request: request!).then(
                (res) => res.fold(
                  (l) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackbarMessage(
                        "Login failed. Please check your credentials.",
                        Colors.redAccent,
                      ),
                    );
                  },
                  (r) {
                    // print(r);
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(255, 170, 0, 1),
          foregroundColor: Colors.black,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: deviceSize.width / 3.7,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          "SUBMIT",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Flexible _dropDown(Size deviceSize) {
    return Flexible(
      flex: 2,
      child: Container(
        width: deviceSize.width / 1.5,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(30, 30, 30, 1),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(
            BorderSide(
              color: Color.fromRGBO(30, 30, 30, 1),
            ),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: Color.fromRGBO(30, 30, 30, 1),
            value: item,
            items: items.map((String e) {
              return DropdownMenuItem(
                enabled: e == "Select Directory" ? false : true,
                value: e,
                child: Text(
                  e,
                  style: TextStyle(
                    color: e == "Select Directory"
                        ? Color.fromARGB(255, 95, 95, 95)
                        : Color.fromARGB(255, 192, 192, 192),
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
    );
  }

  Flexible _logoSection(Size deviceSize) {
    return Flexible(
      flex: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: deviceSize.width / 1.2,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RotatedBox(
              quarterTurns: 3,
              child: Transform.scale(
                scale: 1.5,
                child: Image.asset(
                  "img/bg_logo_bg.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: deviceSize.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Transform.scale(
              scale: 0.5,
              child: Image.asset(
                "img/DIGIO_UP.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
