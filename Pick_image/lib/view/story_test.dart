import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickle_intern_2021/models/product.dart';
import 'package:pickle_intern_2021/models/user_model.dart';
import 'package:pickle_intern_2021/widget/item_card.dart';

class Story_test extends StatefulWidget {
  const Story_test({Key key}) : super(key: key);

  @override
  _Story_testState createState() => _Story_testState();
}

class _Story_testState extends State<Story_test> {
  PageController _pageController;

  bool last = false;
  int _currentIndex = 0;
  int i = 0;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }



  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('post').orderBy('postDate', descending: false).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator();
              }

              for (i; i < snapshot.data.docs.length; i++) {
                final User user = User(
                  name: 'kimYoungmin',
                  profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
                  description: snapshot.data.docs[i]['description'],
                );

                if(snapshot.data.docs.length <= products.length){
                  break;
                }
                Product product = new Product(
                  id: snapshot.data.docs[i]['publicity'],
                  title: snapshot.data.docs[i]['description'],
                  imageList: snapshot.data.docs[i]['images'],
                  user: user,
                );

                products.add(product);
              }

              return GestureDetector(
                onTapDown: (details) => _onTapDown(details, products),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          controller: _pageController,
                          itemCount: snapshot.data.docs.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) {
                            _currentIndex = index;
                            return ItemCard(product: products[_currentIndex]);
                          }
                    ),
                    ),
                  ],
                ),
              );
            }));
  }

  void _onTapDown(TapDownDetails details, imageList) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    print("CurrenIndex : ${_currentIndex}");
    print("products.length : ${products.length}");

    if (dx < screenWidth / 4) {
      setState(() {
        if(_currentIndex -1 >= 0){
          _currentIndex -= 2;
          _loadImage(image: imageList[_currentIndex]);
        }
        else{
          _currentIndex = 0;
          _loadImage(image: imageList[_currentIndex]);
        }
          print("CurrenIndex : ${_currentIndex}");
          print("products.length : ${products.length}");
      });
    } else if (dx > screenWidth * 0.8) {
      setState(() {
        if (_currentIndex < products.length) {
          _loadImage();
        }
        else {
          _currentIndex = 0;
          _loadImage();
        }
      });
    }
  }
  

  void _loadImage({image, bool animateToPage = true}) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(microseconds: 1),
          curve: Curves.easeInOutExpo,
        );
  }

}
