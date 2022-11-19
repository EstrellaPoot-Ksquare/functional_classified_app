import 'package:flutter/material.dart';

class ProfileCircleAppbar extends StatefulWidget {
  const ProfileCircleAppbar({
    Key? key,
    required this.data,
    required this.context,
  }) : super(key: key);
  final dynamic data;
  final BuildContext context;

  @override
  State<ProfileCircleAppbar> createState() => _ProfileCircleAppbarState();
}

class _ProfileCircleAppbarState extends State<ProfileCircleAppbar> {
  @override
  Widget build(BuildContext context) {
    var image = widget.data.toJson()['imgURL'];
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: (10),
      ),
      child: image.isEmpty
          ? const CircleAvatar(
              backgroundImage: AssetImage('images/no-image.png'),
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
    );
  }
}
