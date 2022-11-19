import 'package:classified_app/commons/validators.dart';
import 'package:classified_app/custom_widgets/custom_widgets.dart';
import 'package:classified_app/models/models.dart';
import 'package:classified_app/services/services.dart';
import 'package:classified_app/utils/alert_manager.dart';
import 'package:classified_app/utils/close_keyboard.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _loading = false;
  void _registerFailed() {
    KeyboardFunctions().closeKeyboard(context);
    AlertManager().displaySnackbar(context, 'Register failed');
  }

  void _registerSuccess() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
    AlertManager().displaySnackbar(context, 'Register Successful');
  }

  void _register(UserModel user) async {
    _loading = true;
    setState(() {});
    var resp = await AuthService().register(user);
    _loading = false;
    setState(() {});
    if (resp) {
      _registerSuccess();
    } else {
      _registerFailed();
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var inputStyle = const TextStyle(
      fontSize: 20,
    );
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
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
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) =>
                              Validators.validateStringNotEmpty(value),
                          controller: _fullNameCtrl,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                            labelText: 'Full Name',
                          ),
                          style: inputStyle,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            labelText: 'Mobile Number',
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
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          style: inputStyle,
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
                                      name: _fullNameCtrl.text,
                                      email: _emailCtrl.text,
                                      mobile: _phoneCtrl.text,
                                      password: _passwordCtrl.text,
                                    );
                                    print(user.toJson());
                                    // AuthService().register(user);
                                    // Navigator.pushReplacementNamed(context, '/home');
                                    _register(user);
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
                                _loading ? 'Registering' : 'Register',
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
                          child: const Text('Already have an account?'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const SizedBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
