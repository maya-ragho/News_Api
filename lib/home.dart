import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/product_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  List<String> sliderList = [
    'assets/images/pic_1.jpg',
    'assets/images/pic_2.jpg',
    'assets/images/pic_3.jpg',
    'assets/images/pic_4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 4, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News App'),
          centerTitle: true,
        ),
        bottomNavigationBar:
            BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xffFA6650),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: Color(0xff000000),
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_rounded,
              color: Color(0xff000000),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: Color(0xff000000),
            ),
            label: "message",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color(0xff000000),
            ),
            label: "Person",
          ),
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 6, right: 12, top: 6, bottom: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: 'Search',
                        suffixIcon: Icon(
                          Icons.mic,
                          size: 22,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 22,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.all(0.0),
                    child: SizedBox(
                      height: 150,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 100),
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          enlargeFactor: 0.5,
                          viewportFraction: 0.9,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemCount: sliderList.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            margin: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(color: Colors.white),
                            child: SizedBox(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  sliderList[index].toString(),
                                  fit: BoxFit.fitWidth,
                                )),
                          );
                        },
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),

          Consumer<ProductProvider>(builder: (context, provider, child) {
            provider.fetchProducts();
            return

              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) =>  Container(
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
                      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                       Text(provider.products[index].source!.id.toString()),
                       Text(provider.products[index].author.toString()),
                      Text(provider.products[index].title.toString()),
                       Text(provider.products[index].description.toString()),
                       Image.network(provider.products[index].url.toString()),
                      Image.network(provider.products[index].urlToImage.toString()),
                       Text(provider.products[index].publishedAt.toString()),
                       Text(provider.products[index].content.toString()),
                  ],
                                  ),
                    ))
              );
          }
         )
            ],
            ),
          ),
        ));
  }

  Widget getLoadingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitSquareCircle(
            color: Colors.blueAccent,
            size: 80.0,
            //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
          ),
          Text(
            'Loading........',
            style: TextStyle(fontSize: 20, color: Colors.blueAccent),
          )
        ],
      ),
    );
  }

}
