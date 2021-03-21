import 'package:flutter/material.dart';

class RecipeImageWidget extends StatelessWidget {
  final String imageUrl;

  const RecipeImageWidget({Key key, @required this.imageUrl})
      : assert(imageUrl != null),
        super(key: key);

  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.panorama,
                color: Colors.grey[100],
                size: 50,
              ),
              Text(
                'Image not found',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        );
      },
    );
  }
}
