import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;
  const AdaptiveTextButton(this.text, this.handler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(onPressed: handler, child: Text(text))
        : TextButton(
            onPressed: handler,
            style: Theme.of(context).textButtonTheme.style,
            child: Text(text),
          );
  }
}
