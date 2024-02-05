import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final List messages;
  const ChatBubble({super.key, required this.messages});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        if (widget.messages[index]['isUserMessage']) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(20),
                      // color: Colors.deepPurple,
                    ),
                    color: Color.fromARGB(255, 255, 224, 224),
                  ),
                  constraints: BoxConstraints(maxWidth: width * 2 / 3),
                  child: Text(
                    widget.messages[index]['message'],
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(0),
                      ),
                      color: Color.fromARGB(255, 255, 121, 121)),
                  constraints: BoxConstraints(maxWidth: width * 2 / 3),
                  child: Text(
                    widget.messages[index]['message'],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
