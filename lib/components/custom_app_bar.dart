import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.route,
    this.icon,
    this.actions,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Config.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    if (widget.route != null) {
                      Navigator.of(context).pushNamed(widget.route!);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: widget.icon!,
                  color: Colors.white,
                  iconSize: 16,
                ),
              ),
            )
          : null,
      actions: widget.actions,
    );
  }
}
