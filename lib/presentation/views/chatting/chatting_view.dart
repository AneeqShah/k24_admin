import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_app_bar.dart';
import 'layout/chatting_body.dart';

class ChatView extends StatefulWidget {
  final String customerID;
  final String name;
  final bool fromChat;
  final String productID;

  const ChatView(
      {super.key,
      required this.customerID,
      required this.name,
      required this.fromChat,
      required this.productID});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(widget.name, showIcon: true),
      body: ChatViewBody(
        CustomerID: widget.customerID,
        fromChat: widget.fromChat,
        name: widget.name,
        productID: widget.productID,
      ),
    );
  }
}
