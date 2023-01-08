import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ComponentTestController extends GetxController {
  final TextEditingController textcontroller = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://39a8-102-89-23-40.ngrok.io/ws/send/123'),
  );
  //print(channel);
  int limit = 20;
  int limitIncrement = 20;
  List dataList = [];
  final ScrollController listScrollController = ScrollController();

  @override
  void onInit() async {
    listScrollController.addListener(scrollListener);

    update();
    super.onInit();
  }

  void sendMessage() {
    if (textcontroller.text.isNotEmpty) {
      channel.sink.add(textcontroller.text);
      textcontroller.clear();
      update();
    }
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      limit += limitIncrement;
      update();
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    textcontroller.dispose();
    super.dispose();
  }
}
