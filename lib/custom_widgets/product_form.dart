import 'package:classified_app/commons/validators.dart';
import 'package:classified_app/custom_widgets/custom_widgets.dart';
import 'package:classified_app/models/ad.dart';
import 'package:classified_app/services/services.dart';
import 'package:classified_app/styles/app_theme.dart';
import 'package:classified_app/utils/alert_manager.dart';
import 'package:classified_app/utils/close_keyboard.dart';
import 'package:classified_app/utils/form_controller_generator.dart';
import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  final dynamic data;
  final String? screen;
  const ProductForm({Key? key, this.data, this.screen}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String imagePath = '';
  List<String> imagesList = [];
  void _loadImage(source) async {
    imagePath = await ImagePickerService().loadImageFromDevice(source: source);
    if (imagePath.isNotEmpty) {
      imagesList.add(imagePath);
    }
    setState(() {});
  }

  void _loadMultipleImages() async {
    imagesList = await ImagePickerService().loadMultipleImagesFromDevice();
    setState(() {});
  }

  bool _loading = false;
  _updatingSuccess() {
    Navigator.pop(context);
    AlertManager().displaySnackbar(context, 'Ad updated');
  }

  _updatingFailed() {
    AlertManager().displaySnackbar(context, 'Updating ad failed');
  }

  void _updatingAd(AdModel ad, List<String> newImages, String id) async {
    KeyboardFunctions().closeKeyboard(context);
    _loading = true;
    setState(() {});

    var resp = await AdService().updateAd(ad, newImages, id, context);
    _loading = false;
    setState(() {});
    if (resp) {
      _updatingSuccess();
    } else {
      _updatingFailed();
    }
  }

  _creatingSuccess() {
    Navigator.pop(context);
    AlertManager().displaySnackbar(context, 'Ad created');
  }

  _creatingFailed() {
    AlertManager().displaySnackbar(context, 'Creating ad failed');
  }

  void _creatingAd(AdModel ad, List<String> newImages) async {
    _loading = true;
    setState(() {});
    KeyboardFunctions().closeKeyboard(context);
    var resp = await AdService().createAd(ad, newImages, context);
    _loading = false;
    setState(() {});
    if (resp) {
      _creatingSuccess();
    } else {
      _creatingFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, TextEditingController> ctrl = FormControllers.controllersFor([
      'title',
      'price',
      'mobile',
      'description',
    ], data: widget.data);
    const inputStyle = TextStyle(
      fontSize: 20,
    );
    final double width = MediaQuery.of(context).size.width;
    // imagesList = widget.data['images'];
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 20,
          ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    imagePath = '';
                    setState(() {});
                  },
                  onTap: () {
                    // _loadImage('gallery');
                    // print('path: $imagePath');

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
                                      // _loadImage('gallery');
                                      _loadMultipleImages();
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                      ? ImageUploader(width: width)
                      : SingleImageLoaded(image: imagePath),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (imagesList.isNotEmpty)
                  Column(
                    children: [
                      const Text(
                        'Upload:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.mainColor),
                      ),
                      const SizedBox(height: 5),
                      ImagesList(
                        images: imagesList,
                        color: AppTheme.mainColor.withOpacity(0.3),
                        // images: widget.data['images'],
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                if (widget.screen == 'edit')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImagesList(
                        // images: imagesList,
                        images: widget.data['images'],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                TextFormField(
                  validator: (value) =>
                      Validators.validateStringNotEmpty(value),
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: ctrl['title'],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Title',
                  ),
                  style: inputStyle,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) =>
                      Validators.validateStringNotEmpty(value),
                  controller: ctrl['price'],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price',
                  ),
                  style: inputStyle,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) =>
                      Validators.validateStringNotEmpty(value),
                  controller: ctrl['mobile'],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    hintText: 'Contact Number',
                  ),
                  style: inputStyle,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) =>
                      Validators.validateStringNotEmpty(value),
                  controller: ctrl['description'],
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Description',
                    hintText: 'Description',
                  ),
                  style: inputStyle,
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (Validators.isValidForm(formKey)) {
                      List<String> images = [];
                      images.add(imagePath);
                      AdModel ad = AdModel(
                        title: ctrl['title']!.text,
                        price: double.tryParse(ctrl['price']!.text),
                        mobile: ctrl['mobile']!.text,
                        description: ctrl['description']!.text,
                        // images: imagesList,
                      );
                      if (imagesList.isEmpty && widget.data != null) {
                        ad.images = widget.data['images'];
                      }
                      if (widget.screen != 'edit' && imagesList.isEmpty) {
                        ad.images = ['https://via.placeholder.com/300x400'];
                      }
                      widget.screen == 'edit'
                          ? _updatingAd(ad, imagesList, widget.data['_id'])
                          : _creatingAd(ad, imagesList);
                    }
                  },
                  child: const Text('Submit Ad'),
                ),
                if (!_loading)
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height + 40,
                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                  child: const Center(
                    child: CircularProgressLoading(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
