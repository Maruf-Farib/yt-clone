import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
            ),
            child: const Text(
                "Remember to keep comments respectful and to follow our community and guideline"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 8, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 45,
                  width: 285,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: "Add a comment",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
