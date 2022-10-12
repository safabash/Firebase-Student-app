import 'package:authentication/view/login_form.dart';
import 'package:authentication/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginContoller with ChangeNotifier {
  bool isLogin = true;
  void toggle() {
    isLogin = !isLogin;
    notifyListeners();
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginContoller>(context, listen: false);

    return Consumer<LoginContoller>(
      builder: (context, value, child) {
        return provider.isLogin
            ? LoginForm(onClickedSignUp: provider.toggle)
            : SignUp(onClickedSignIn: provider.toggle);
      },
    );
  }
}
