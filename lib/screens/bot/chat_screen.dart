import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Message {
  final String text;
  final bool isUser;

  Message(this.text, this.isUser);
}

class ChatScreen extends StatefulWidget {
  final String title;
  final String model;

  const ChatScreen({super.key, required this.title, required this.model});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();

  Future<String> generateText(String userMessage) async {
    const apiKey = '';
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": userMessage},
          ],
          "max_tokens": 4000,
          "model": widget.model,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final generatedText = data['choices'][0]['message']['content'];
        return generatedText;
      } else {
        if (kDebugMode) {
          print('HTTP request failed with status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to generate text');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error generating text: $error');
      }
      throw Exception('Failed to generate text');
    }
  }

  void handleUserMessage(String message) {
    setState(() {
      messages.add(Message(message, true));
    });

    // Generate response from OpenAI
    generateText(message).then((response) {
      setState(() {
        messages.add(Message(response, false));
      });
    }).catchError((error) {
      setState(() {
        messages.add(Message('Error generating text', false));
      });
    });

    messageController.clear();
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      // sendMessage(result.recognizedWords);
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void resetChat() {
    setState(() {
      messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF219653),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: message.isUser ? Colors.green : Colors.black,
                    ),
                  ),
                  dense: true,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Light grey color for the input area
              borderRadius: BorderRadius.circular(24),
            ),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (value) {
                      // sendMessage(value);
                      messageController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: "Masukan pertanyaan...",
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                      contentPadding: const EdgeInsets.all(10),
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueGrey),
                  onPressed: () {
                    final userMessage = messageController.text;
                    if (userMessage.isNotEmpty) {
                      handleUserMessage(userMessage);
                    }
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  icon: const Icon(Icons.mic_sharp, color: Colors.blueGrey),
                  onPressed: () {
                    if (_speechToText.isNotListening) {
                      _startListening();
                    } else {
                      _stopListening();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
