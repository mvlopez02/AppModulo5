import 'package:delivery_app/domain/use%20cases/auth_service.dart';
import 'package:delivery_app/helper/helper_function.dart';
import 'package:delivery_app/ui/pages/home_page.dart';
import 'package:delivery_app/ui/pages/login_page.dart';
import 'package:delivery_app/ui/widgets/screen_manager.dart';
import 'package:delivery_app/ui/widgets/snackbar.dart';
import 'package:delivery_app/ui/widgets/text_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/ui/color_palette.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(
                child:
                    CircularProgressIndicator(color: ColorPalette.primaryColor))
            : SingleChildScrollView(
                //create a scroll bar if the screen is overflown
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 80),
                    child: Form(
                        key:
                            formKey, //this will identify this specific Form from others in the app
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.primaryColor),
                            ),
                            const SizedBox(height: 10),
                            Text("Crea tu cuenta",
                                style: TextStyle(
                                    color: ColorPalette.myPalette['text2'],
                                    fontSize: 15,
                                    fontWeight: FontWeight
                                        .w400)), //<Widget> was specidified so we could add this Text
                            const SizedBox(height: 30),
                            Image.asset(
                              'assets/user.png',
                              height: 100,
                              width: 100,
                            ), //image.asset --> an image could be added (create assests folder and to dependencies yaml)
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Nombre completo",
                                  prefixIcon: Icon(Icons.person,
                                      color: ColorPalette.myPalette[
                                          'text2'])), //copyWith: add more values to the text field
                              onChanged: (val) {
                                //take the value of the input
                                setState(() {
                                  fullName =
                                      val; // save the value on email variable
                                });
                              },
                              // check the validation
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Debe ingresar su nombre completo";
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email,
                                      color: ColorPalette.myPalette[
                                          'text2'])), //copyWith: add more values to the text field
                              onChanged: (val) {
                                //take the value of the input
                                setState(() {
                                  email =
                                      val; // save the value on email variable
                                });
                              },
                              // check the validation
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Ingrese un correo electrónico válido";
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
                                  return "La contraseña debe ser de al menos 6 caracteres";
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
                                    backgroundColor:
                                        ColorPalette.myPalette['primary2'],
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {
                                  register();
                                },
                                child: const Text("Sign up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text.rich(TextSpan(
                                text: "¿Ya tienes una cuenta? ",
                                style: TextStyle(
                                    color: ColorPalette.myPalette['text2'],
                                    fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Inicia sesión",
                                      style: const TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          nextScreen(
                                              context, const LoginPage());
                                        })
                                ]))
                          ],
                        )),
                  ),
                ),
              ));
  }

  register() async {
    if (formKey.currentState!.validate()) {
      //validate: makes sure the validator criteria were fullfilled
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        //value = true || error
        if (value == true) {
          // saving the shared preferences state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
