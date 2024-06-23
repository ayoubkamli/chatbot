import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

//sk-proj-VzyehLmXW75lQXz8YOmJT3BlbkFJCVkEqrM172bzEsubu1Ij
//sk-proj-hMhrQjtcMb9XjHcwOHG8T3BlbkFJ9ZEHFy5gVCBszTkgNjKO

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  String? gptUrl = dotenv.env['API_GPT_BASE_URL'];
  String? gptKey = dotenv.env['API_GPT_KEY'];
  String? gptPath = dotenv.env['API_GPT_PATH'];
  List<dynamic> data = [
    {'message': 'How can i help you', 'type': 'assistant'},
    {'message': 'I am a helful assistant', 'type': 'assistant'},
  ];

  TextEditingController queryController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                bool isUser = data[index]['type'] == 'user';
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            SizedBox(
                              width: isUser ? 100 : 0,
                            ),
                            Expanded(
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: (isUser)
                                      ? const Color.fromARGB(50, 0, 255, 0)
                                      : Colors.white,
                                  child: Text(
                                    data[index]['message'],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: isUser ? 0 : 100,
                            )
                          ],
                        ),
                        leading:
                            (!isUser) ? const Icon(Icons.support_agent) : null,
                        trailing: (isUser) ? const Icon(Icons.person_2) : null,
                      ),
                    ),
                    const Divider(
                      height: 1,
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: queryController,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.visibility),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    var query = queryController.text;
                    var url = Uri.https("$gptUrl", "$gptPath");
                    Map<String, String> userHeaders = {
                      "Content-type": "application/json",
                      "Authorization": "Bearer $gptKey"
                    };
                    http
                        .post(url,
                            headers: userHeaders,
                            body: json.encode({
                              "model": "gpt-3.5-turbo",
                              "messages": [
                                {"role": "user", "content": query}
                              ],
                              "temperature": 0.7
                            }))
                        .then((resp) {
                      var result = json.decode(resp.body);
                      print("result ------------ ---- - -- -");
                      print({result});
                      var llmRes = result['choices'][0]['message']['content'];
                      setState(() {
                        data.add({
                          "message": result['choices'][0]['message']['content'],
                          "type": "assistant"
                        });
                        data.add({'message': query, 'type': 'user'});

                        data.add({'message': llmRes, 'type': 'assistant'});
                        print("test");

                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 60);
                      });
                    }, onError: (err) {
                      print("-------------------- ERROR------------");
                      print(err);
                    });
                    setState(() {
                      data.add({'message': query, 'type': 'user'});
                      scrollController.jumpTo(
                          scrollController.position.maxScrollExtent + 60);
                      data.add({'message': "loading...", 'type': 'assistant'});
                      print("test");
                    });
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
