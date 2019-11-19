import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

// Other dart flies import
import 'package:ralph_store/components/horizontal_listview.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    // Sliding image also known as carousel

    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
//        dotSize: 4.0,
        indicatorBgPadding:6.0 ,
        dotColor: Colors.red,
      ),
    );

    return Scaffold(
      // Topmost of the App
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text('RalphStore'),

        //Search Icon and shopping cart

        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),

      // The side bar also known as drawer

      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
//          Header of the drawer
            new UserAccountsDrawerHeader(
              accountName: Text('Sample Name'),
              accountEmail: Text('Test@email.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.redAccent),
            ),
//          Body of the drawer
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourite'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
// Break in the line
            Divider(),
//Continuation of the body
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),

      body: new ListView(
        children: <Widget>[

          // Calling the image carousel
          image_carousel,

          // Padding widget for displaying category header
          new Padding(padding: const EdgeInsets.all(6.0),
          child: new Text('Categories'),),

          // Horizontal List for category from horizontal_listview.dart file
          HorizontalList(),

          // Padding widget for displaying Recent item header
          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text('Recent Items'),),

          //Grid view for recent Items
          Container(
            height: 320.0,
            child: Products(),
          ),
        ],
      ),
    );
  }
}
