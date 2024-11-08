
import 'package:flutter/material.dart';

void showSnacBarMassage(BuildContext context, String massage,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(massage),

    ),
  );
}