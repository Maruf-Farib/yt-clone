import 'package:flutter/material.dart';
import 'package:yt/cores/colors.dart';
import 'package:yt/cores/widgets/image_button.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: softBlueGreyBackGround,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text('Manage Videos'),
              ),
            ),
          ),
          Expanded(
            child: ImageButton(
              onPressed: () {},
              image: 'pen.png',
              haveColor: true,
            ),
          ),
          Expanded(
            child: ImageButton(
              onPressed: () {},
              image: 'time-watched.png',
              haveColor: true,
            ),
          ),
        ],
      ),
    );
  }
}
