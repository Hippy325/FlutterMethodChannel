import 'package:flutter/material.dart';
import 'package:flutter_method_channel/method_channel_client.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final MethodChannelClient _client = MethodChannelClient();

  int counter = 0;
  String fileContent = "";

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final content = await _client.readFile();
    counter = _getLastN(content);

    setState(() {
      fileContent = content;
    });
  }

  int _getLastN(String text) {
    final lines = text.trim().split("\n");
    if (lines.isEmpty || lines.first.isEmpty) return 0;

    final last = lines.last.split(" ");
    final n = int.tryParse(last.last);
    return n ?? 0;
  }

  Future<void> _onPressed() async {
    counter++;
    final newLine = "hello world $counter";
    final updatedContent = await _client.writeString(newLine);

    setState(() {
      fileContent = updatedContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MethodChannel")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _onPressed,
                  child: const Text("Увеличить счетчик"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: Text(fileContent))),
          ],
        ),
      ),
    );
  }
}
