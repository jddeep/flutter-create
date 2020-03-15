import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'accomMe',
        theme: ThemeData(fontFamily: 'GoogleSans'),
        debugShowCheckedModeBanner: false,
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ListView(physics: NeverScrollableScrollPhysics(), children: <Widget>[
        Container(color: Colors.white,
            padding: EdgeInsets.only(
                top: 20.0, right: 15.0, bottom: 10.0, left: 15.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.hotel, color: Colors.black, size: 38.0),
                  Text('accomMe', style: TextStyle(fontSize: 20.0)),
                  Container(height: 50.0,
                      width: 50.0,
                      margin: EdgeInsets.only(right: 8.0, top: 10.0),
                      child: Image(image: AssetImage('assets/hotel_animation.gif')))
                ])),
        Padding(padding: EdgeInsets.only(top: 20.0),
            child: TabBar(controller: tabController,
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.6),
                isScrollable: true,
                tabs: <Widget>[
                  Tab(child: Text('5-star', style: TextStyle(fontSize: 33.0))),
                  Tab(child: Text('4-star', style: TextStyle(fontSize: 33.0))),
                  Tab(child: Text('3-star', style: TextStyle(fontSize: 33.0)))
                ])),
        Container(height: MediaQuery.of(context).size.height,
            child: TabBarView(controller: tabController, children: <Widget>[
              hotelsPage(context),
              hotelsPage(context),
              hotelsPage(context)
            ]))
      ]),
    );
  }

  Widget hotelsPage(BuildContext context) {
    return Container(decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/background.png'),
             fit: BoxFit.cover)),
        child: ListView(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
            Column(children: <Widget>[
              hotelCard('assets/hotelimg1.jpg', 'Holiday Inn', '500', true, context),
              hotelCard('assets/hotelimg2.jpg', 'Pacific Hotel', '600', false, context)]),
            Column(children: <Widget>[
              hotelCard('assets/hotelimg3.jpg', 'The Oasis', '700', false, context),
              hotelCard('assets/hotelimg4.jpg', 'Rangoli Hotel', '800', true, context)])
          ])
        ]));
  }

  Widget hotelCard(String pic, String hotelName, String price, bool like,
      BuildContext context) {
    return Padding(padding: EdgeInsets.all(10.0),
        child: Container(height: 200.0,
            width: (MediaQuery.of(context).size.width / 2) - 20.0,
            child: Card(elevation: 10.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: GestureDetector(
                    onTap: () => showDialog(context: context,
                          builder: (_) => AlertDialog(
                              content: Image(image: AssetImage(pic))
                              )),
                    child: Column(children: <Widget>[
                      Stack(children: <Widget>[
                        Container(height: 125.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                                image: DecorationImage(image: AssetImage(pic),
                                    fit: BoxFit.cover))),
                        Padding(padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.topRight,
                                child: like
                                    ? Icon(Icons.trending_up, color: Colors.white)
                                    : null))
                      ]),
                      SizedBox(height: 15.0),
                      Text(hotelName, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('\$' + price + ' per day')
                    ])))));
  }
}
