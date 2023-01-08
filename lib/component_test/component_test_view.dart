import 'package:clypin/component_test/component_test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComponentTest extends StatelessWidget {
  const ComponentTest({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComponentTestController>(
      init: ComponentTestController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.sendMessage();
            },
            tooltip: 'Send message',
            child: const Icon(Icons.send),
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Form(
                    child: TextFormField(
                      controller: controller.textcontroller,
                      decoration:
                          const InputDecoration(labelText: 'Send a message'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  StreamBuilder(
                    stream: controller.channel.stream,
                    //controller: controller.listScrollController,
                    builder: (context, snapshot) {
                      //controller.dataList.add(snapshot);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Text(
                        snapshot.hasData ? '${snapshot.data}' : '',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
/*ListView.separated(
                        itemBuilder: (context, index) {
                          return Text(snapshot.data[index]);
                        },
                        separatorBuilder: (context, index) {
                        },
                        itemCount: snapshot.data);*/