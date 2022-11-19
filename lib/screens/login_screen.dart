import 'package:classified_app/commons/validators.dart';
import 'package:classified_app/models/models.dart';
import 'package:classified_app/services/services.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/custom_widgets.dart';
import '../utils/alert_manager.dart';
import '../utils/close_keyboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  void _login(context, UserModel user, String redirectRoute) async {
    _loading = true;
    setState(() {});
    var resp = await AuthService().login(context, user, '/home');
    _loading = false;
    setState(() {});
    if (resp.runtimeType == bool && !resp) {
      KeyboardFunctions().closeKeyboard(context);
      AlertManager().displaySnackbar(context, 'Login failed');
    } else {
      Navigator.pushReplacementNamed(
        context,
        redirectRoute,
        arguments: resp,
      );
      AlertManager().displaySnackbar(context, 'Login Successful');
    }
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    var inputStyle = const TextStyle(
      fontSize: 20,
    );
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                HeroImage(height: height, width: width),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) => Validators.validateEmail(value),
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email Address',
                            labelText: 'Email Address',
                          ),
                          style: inputStyle,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) =>
                              Validators.validateStringNotEmpty(value),
                          controller: _passwordCtrl,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: _loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    UserModel user = UserModel(
                                      email: _emailCtrl.text,
                                      password: _passwordCtrl.text,
                                    );
                                    _login(context, user, '/home');
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.black38,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_loading)
                                Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const CircularProgressIndicator(
                                    color: Color.fromRGBO(242, 87, 35, 0.6),
                                    strokeWidth: 3,
                                  ),
                                ),
                              Text(
                                _loading ? 'Starting sesion' : 'Login',
                                style: TextStyle(
                                    color: _loading
                                        ? const Color.fromRGBO(242, 87, 35, 1)
                                        : Colors.white,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text("Don't have any account?"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
