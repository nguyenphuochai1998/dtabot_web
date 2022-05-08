import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsTag extends StatelessWidget {
  const NewsTag({Key? key, required String imageUrl, required String content})
      : _content = content,
        _urlImage = imageUrl,
        super(key: key);

  final String _urlImage;
  final String _content;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
            child: Image.network(
              _urlImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            _content,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
