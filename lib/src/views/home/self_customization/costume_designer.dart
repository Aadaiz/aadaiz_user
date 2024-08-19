import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Costume extends StatefulWidget {
  const Costume({Key? key}) : super(key: key);

  @override
  State<Costume> createState() => _CostumeState();
}

class _CostumeState extends State<Costume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: DraggableExample()),
    );
  }
}

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  List<Map<String, dynamic>> acceptedImages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: DragTarget<Map<String, dynamic>>(
            builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
                ) {
              return Container(
                width: Get.width,
                height: Get.height * 0.6,
                color: Colors.cyan,
                child: Stack(
                  children: acceptedImages.map((imageData) {
                    return Positioned(
                      left: imageData['offset'].dx,
                      top: imageData['offset'].dy,
                      child: imageData['image'],
                    );
                  }).toList(),
                ),
              );
            },
            onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
              setState(() {
                acceptedImages.add({
                  'image': details.data['image'],
                  'offset': details.offset,
                });
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Draggable<Map<String, dynamic>>(
              data: {
                'image': Image.asset('assets/self/collar.png', width: 100, height: 100),
              },
              feedback: Image.asset('assets/self/collar.png', width: 100, height: 100),
              childWhenDragging: Container(),
              child: Image.asset('assets/self/collar.png', width: 100, height: 100),
            ),
            const SizedBox(width: 20),
            Draggable<Map<String, dynamic>>(
              data: {
                'image': Image.asset('assets/self/collar1.png', width: 100, height: 100),
              },
              feedback: Image.asset('assets/self/collar1.png', width: 100, height: 100),
              childWhenDragging: Container(),
              child: Image.asset('assets/self/collar1.png', width: 100, height: 100),
            ),
          ],
        ),
      ],
    );
  }
}


