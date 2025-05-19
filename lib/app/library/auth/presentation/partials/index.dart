import 'package:myapp/app/library/auth/presentation/partials/textfield.partials.auth.dart';

class TextField {
  List<TextFieldPartial> partial(
    deviceSize,
    isObscure,
    isLoading,
    isGoogleLogin,
    changeObscure,
  ) {
    return [
      TextFieldPartial(
        deviceSize: deviceSize,
        hint: "Username",
        errMessage: "Username Cannot be empty",
        isObscure: false,
        isLoading: isLoading,
        isGoogleLogin: isGoogleLogin,
        changeObscure: changeObscure,
      ),
      TextFieldPartial(
        deviceSize: deviceSize,
        hint: "Password",
        errMessage: "Password Cannot be empty",
        isObscure: !isObscure,
        isLoading: isLoading,
        isGoogleLogin: isGoogleLogin,
        changeObscure: changeObscure,
      ),
    ];
  }
}
