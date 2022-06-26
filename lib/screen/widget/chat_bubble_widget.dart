import 'dart:io';

import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatefulWidget {
  final String text;
  final bool isMe;
  final bool isSendedImage;
  const ChatBubbleWidget({
    Key? key,
    required this.text,
    required this.isMe,
    required this.isSendedImage,
  }) : super(key: key);

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: widget.isMe ? 0 : 20,
            right: widget.isMe ? 20 : 0,
            bottom: 22,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomRight: Radius.circular(widget.isMe ? 0 : 12),
              bottomLeft: Radius.circular(widget.isMe ? 12 : 0),
            ),
            color:
                widget.isMe ? const Color(0xffFFFFFF) : const Color(0xffF1EBE5),
          ),
          child: widget.isSendedImage
              ? Image.file(
                  File(widget.text),
                  width: 200,
                  height: 200,
                )
              : SizedBox(
                  width: 230,
                  child: Text(
                    widget.text,
                    textScaleFactor: 1.0,
                  ),
                ),
        ),
      ],
    );
  }
}
