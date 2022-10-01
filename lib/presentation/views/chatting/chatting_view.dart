import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_app_bar.dart';
import 'layout/chatting_body.dart';

class ChatView extends StatefulWidget {
  final String customerID;

  const ChatView({super.key, required this.customerID});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Luna', showIcon: true),
      body: ChatViewBody(CustomerID: widget.customerID),
    );
  }
}
