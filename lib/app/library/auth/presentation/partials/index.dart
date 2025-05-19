import 'package:myapp/app/library/auth/presentation/partials/textfield.partials.auth.dart';

class TextField {
  List<TextFieldPartial> partial(
    deviceSize,
    isObscure,
    isLoading,
    isGoogleLogin,
  ) {
    return [
      TextFieldPartial(
        deviceSize: deviceSize,
        hint: "username",
        errMessage: "Username Cannot be empty",
        isObscure: !isObscure,
        isLoading: isLoading,
        isGoogleLogin: isGoogleLogin,
      ),
    ];
  }
}
