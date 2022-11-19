import 'package:flutter/material.dart';

class EditProfileAppbar extends StatelessWidget {
  const EditProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: const Key('EditAppbar'),
      title: const Text('Edit Profile'),
      centerTitle: true,
    );
  }
}
