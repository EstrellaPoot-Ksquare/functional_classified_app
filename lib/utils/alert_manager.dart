import 'package:classified_app/styles/app_theme.dart';
import 'package:flutter/material.dart';

class AlertManager {
  displaySnackbar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            '$text',
            style: const TextStyle(
                color: AppTheme.mainColor, fontWeight: FontWeight.bold),
          ),
        ),
        duration: const Duration(milliseconds: 1500),

        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
