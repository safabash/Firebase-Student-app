import 'package:flutter/material.dart';

class CommonSizedBox extends StatelessWidget {
  const CommonSizedBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class Styles {
  static TextStyle buttonTextStyle() {
    return const TextStyle(
        fontSize: 14, letterSpacing: 2.2, color: Colors.white);
  }
}

class Button extends StatelessWidget {
  final Function()? function;
  String text;
  Button({Key? key, this.function, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
      onPressed: function,
      child: Text(text, style: Styles.buttonTextStyle()),
    );
  }
}
