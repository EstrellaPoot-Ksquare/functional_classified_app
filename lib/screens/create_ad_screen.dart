import 'package:classified_app/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create Ad'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            const ProductForm(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
