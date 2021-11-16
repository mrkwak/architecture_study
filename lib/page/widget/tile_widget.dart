import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    Key? key,
    required this.contentNo,
    required this.content,
    required this.contentDate,
    required this.onPressed,
  }) : super(key: key);
  final String contentNo;
  final String content;
  final String contentDate;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        horizontalTitleGap: 100,
        minLeadingWidth: 0,
        leading: Text(contentNo, style: const TextStyle(height: 2.5)),
        title: Text(content),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_right),
          iconSize: 50,
          onPressed: () => onPressed(),
        ),
        subtitle: contentDate != "" ? Text(contentDate) : const SizedBox());
  }
}
