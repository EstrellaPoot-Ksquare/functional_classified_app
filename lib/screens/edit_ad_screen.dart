import 'package:classified_app/custom_widgets/custom_widgets.dart';
import 'package:classified_app/models/ad.dart';
import 'package:classified_app/services/ad_service.dart';
import 'package:classified_app/utils/alert_manager.dart';
import 'package:flutter/material.dart';

class EditAdScreen extends StatefulWidget {
  const EditAdScreen({super.key, required this.data});
  final dynamic data;

  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  bool deleted = false;
  AdModel myAd = AdModel();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print('data: ${widget.data}');
    print('data: ${widget.data['_id']}');
    previousScreen() {
      Navigator.pop(context);
      Navigator.pop(context);
      AlertManager().displaySnackbar(context, 'Ad deleted');
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Delete Ad',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              content: const Text('Ad will be deleted permanently'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    String id = widget.data['_id'];
                    deleted = await AdService().deleteAd(id);
                    // deleted = false;
                    if (deleted) {
                      previousScreen();
                    } else {
                      await showDialog(
                          context: context,
                          builder: (contex) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Something went wrong'),
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.offline_share))
                              ],
                            );
                          });
                    }

                    // Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.delete_forever_sharp,
          size: 35,
        ),
      ),
      appBar: AppBar(
        title: const Text('Edit Ad'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            ProductForm(data: widget.data, screen: 'edit'),
          ],
        ),
      ),
    );
  }
}
