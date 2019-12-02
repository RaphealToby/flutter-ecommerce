import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 80.0,
      height: 50.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_caption: 'Accessories',
            image_location: 'images/cats/accessories.png',
          ),
          Category(
            image_caption: 'Dress',
            image_location: 'images/cats/dress.png',
          ),
          Category(
            image_caption: 'Formal',
            image_location: 'images/cats/formal.png',
          ),
          Category(
            image_caption: 'Informal',
            image_location: 'images/cats/informal.png',
          ),
          Category(
            image_caption: 'Jeans',
            image_location: 'images/cats/jeans.png',
          ),
          Category(
            image_caption: 'Shoes',
            image_location: 'images/cats/shoe.png',
          ),
          Category(
            image_caption: 'Shirt',
            image_location: 'images/cats/tshirt.png',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  //Constructor creation
  Category({this.image_caption,this.image_location,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding determine the closeness in position to the preceeding item
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 110.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}
