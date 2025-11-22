import 'package:flutter/services.dart';

class MethodChannelClient {
  static const MethodChannel _channel = MethodChannel("Channel");

  Future<String> writeString(String text) async {
    final result = await _channel.invokeMethod("writeString", {"text": text});
    return result ?? "";
  }

  Future<String> readFile() async {
    final result = await _channel.invokeMethod("readFile");
    return result ?? "";
  }
}
