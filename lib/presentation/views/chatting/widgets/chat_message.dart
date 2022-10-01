import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../model/message.dart';

class MessageRowWidget extends StatelessWidget {
  final String message;
  final bool current;

  const MessageRowWidget(
      {Key? key, required this.message, required this.current})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          current ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          current ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: current ? 30.0 : 20.0),
        Container(

          padding: const EdgeInsets.only(
            bottom: 5,
            right: 5,
          ),
          child: Column(
            crossAxisAlignment:
                current ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minHeight: 40,
                  maxHeight: 250,
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  minWidth: MediaQuery.of(context).size.width * 0.1,
                ),
                decoration: BoxDecoration(
                    color: current ? Colors.white : Colors.white,
                    borderRadius: current
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                    border: Border.all(
                        color: current
                            ? Colors.red.withOpacity(0.3)
                            : Colors.black.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, bottom: 5, right: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: current
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: current ? 10.0 : 30.0),
      ],
    );
  }
}
