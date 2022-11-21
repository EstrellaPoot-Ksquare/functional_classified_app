import 'dart:io';

import 'package:classified_app/commons/validators.dart';
import 'package:classified_app/custom_widgets/circular_progress_loading.dart';
import 'package:classified_app/models/models.dart';
import 'package:classified_app/services/services.dart';
import 'package:classified_app/styles/app_theme.dart';
import 'package:classified_app/utils/alert_manager.dart';
import 'package:classified_app/utils/close_keyboard.dart';
import 'package:classified_app/utils/form_controller_generator.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/edit_profile_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  // final dynamic data;
  final UserModel myUser;
  const EditProfileScreen({
    super.key,
    required this.myUser,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map<String, TextEditingController> ctrl = {};
  @override
  void initState() {
    ctrl = FormControllers.controllersFor([
      'name',
      'email',
      'mobile',
    ], data: widget.myUser.toJson());
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String imagePath = '';
  void _loadImage(source) async {
    imagePath = await ImagePickerService().loadImageFromDevice(source: source);
    setState(() {});
  }

  bool _loading = false;
  _updatingSucess() {
    AlertManager().displaySnackbar(context, 'Profile updated');
    Navigator.pop(context);
  }

  _updatingFailed() {
    KeyboardFunctions().closeKeyboard(context);
    AlertManager().displaySnackbar(context, 'Register failed');
  }

  void _updatingProfile(user, filePath) async {
    KeyboardFunctions().closeKeyboard(context);
    _loading = true;
    setState(() {});
    var resp =
        await ProfileService().updateUserProfile(context, user, filePath);
    _loading = false;
    setState(() {});
    if (resp) {
      _updatingSucess();
    } else {
      _updatingFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key('EditScaffold'),
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: EditProfileAppbar()),
        body: Stack(
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 50,
                              color: AppTheme.mainColor,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          _loadImage('gallery');
                                        },
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'Gallery',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Icon(
                                                Icons.image_outlined,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      height: 50,
                                      width: 1,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _loadImage('camera');
                                            },
                                            label: const Text(
                                              'Camera',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            icon: const Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: imagePath.isEmpty
                          ? ImgCircularNetwork(
                              image: widget.myUser.imgURL!,
                            )
                          : ImgCircularFile(image: imagePath),
                    ),
                    const SizedBox(height: 15),
                    Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            enableSuggestions: false,
                            validator: (value) =>
                                Validators.validateStringNotEmpty(value),
                            controller: ctrl['name'],
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'Full Name',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            validator: (value) =>
                                Validators.validateEmail(value),
                            controller: ctrl['email'],
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Email Address',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            validator: (value) =>
                                Validators.validateStringNotEmpty(value),
                            controller: ctrl['mobile'],
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Mobile Number',
                              hintText: 'Mobile Number',
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              print(ctrl);
                              print(ctrl);

                              if (Validators.isValidForm(formKey)) {
                                UserModel updateUser = UserModel(
                                  name: ctrl['name']!.text,
                                  email: ctrl['email']!.text,
                                  mobile: ctrl['mobile']!.text,
                                );
                                if (imagePath.isEmpty &&
                                    widget.myUser.imgURL != null) {
                                  updateUser.imgURL = widget.myUser.imgURL!;
                                }
                                _updatingProfile(updateUser, imagePath);
                              }
                            },
                            child: const Text('Update Profile'),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: const Text('Logout'),
                          )
                        ],
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
            if (_loading)
              Container(
                color: const Color.fromRGBO(0, 0, 0, 0.3),
                child: const Center(
                  child: CircularProgressLoading(),
                ),
              ),
          ],
        ));
  }
}

class ImgCircularNetwork extends StatelessWidget {
  const ImgCircularNetwork({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(height * 0.2),
      child: FadeInImage(
        placeholder: const AssetImage('images/jar-loading.gif'),
        image: NetworkImage(
          image,
        ),
        height: height * 0.2,
        width: height * 0.2,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ImgCircularFile extends StatelessWidget {
  const ImgCircularFile({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(height * 0.2),
      child: Image.file(
        File(image),
        height: height * 0.2,
        width: height * 0.2,
        fit: BoxFit.cover,
      ),
    );
  }
}
