import 'package:delivery_app/ui/color_palette.dart';
import 'package:delivery_app/ui/pages/register_page.dart';
import 'package:delivery_app/ui/widgets/screen_manager.dart';
import 'package:delivery_app/ui/widgets/text_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //create a scroll bar if the screen is overflown
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Form(
                key:
                    formKey, //this will identify this specific Form from others in the app
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "AppName",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Text("Únete a nuestra aplicación",
                        style: TextStyle(
                            color: ColorPalette.myPalette['text2'],
                            fontSize: 15,
                            fontWeight: FontWeight
                                .w400)), //<Widget> was specidified so we could add this Text
                    Lottie.asset(
                      'assets/chat-animation.json',
                      height: 300,
                      width: 300,
                    ), //image.asset --> an image could be added (create assests folder and to dependencies yaml)
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email,
                              color: ColorPalette.myPalette[
                                  'text2'])), //copyWith: add more values to the text field
                      onChanged: (val) {
                        //take the value of the input
                        setState(() {
                          email = val; // save the value on email variable
                        });
                      },
                      // check the validation
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock,
                              color: ColorPalette.myPalette[
                                  'text2'])), //copyWith: add more values to the text field
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          login();
                        },
                        child: const Text("Sign in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(TextSpan(
                        text: "¿No tienes una cuenta todavía? ",
                        style: TextStyle(
                            color: ColorPalette.myPalette['text2'],
                            fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Regístrate",
                              style: const TextStyle(
                                  color: ColorPalette.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const RegisterPage());
                                })
                        ]))
                  ],
                )),
          ),
        ),
      ),
    );
  }

  login() {}
}
