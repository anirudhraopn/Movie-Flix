import 'package:flutter/material.dart';

import 'app_bottom_bar.dart';

class AlertTheUser extends StatelessWidget {
  const AlertTheUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('There was some Error'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AppBottomBar()),
                (route) => route.isFirst);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
