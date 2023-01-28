import 'package:flutter/material.dart';

class EmptyNotePage extends StatelessWidget {
  const EmptyNotePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/image/mainImage.png",
            height: 286,
            width: 350,
          ),
        ),
        // if(data.isEmpty)
        const Text(
          "Create your first note",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}