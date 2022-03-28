import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSize {
  const CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      backgroundColor: Theme.of(context).primaryColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(CupertinoIcons.back),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Back',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
