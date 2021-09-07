import 'package:flutter/material.dart';
import 'package:pickle_intern_2021/models/product.dart';
import 'package:pickle_intern_2021/provider/image_provider.dart';
import 'package:pickle_intern_2021/view/post_make_screen.dart';
import 'package:pickle_intern_2021/widget/animation_bar.dart';
import 'package:pickle_intern_2021/widget/user_Info.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
  final Product product;

  const ItemCard({@required this.product});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
    with SingleTickerProviderStateMixin {
  List<bool> badList = <bool>[];
  int _currentIndex = 0;
  int counterValue = 0;
  dynamic _currentImage;
  dynamic _fixedImage;

  bool picked = false;

  bool counterListening = false;

  PageController _pageController;
  AnimationController _animController;

  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    _loadImage(image: widget.product.imageList.first, animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.product.imageList.length) {
            _currentIndex += 1;
            _loadImage(image: widget.product.imageList[_currentIndex]);
          } else if (_currentIndex == widget.product.imageList.length) {
            setState(() {
              _animController.stop();
            });
          }
        });
      }
    });
  }

  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // PickImageProvider image_provider = Provider.of<PickImageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
            if (widget.product.imageList.isEmpty)
              Container()
            else
              Column(
                children: [
                  GestureDetector(
                    onTapDown: (details) =>
                        _onTapDown(details, widget.product.imageList),
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.92,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                            controller: _pageController,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.product.imageList.length,
                            itemBuilder: (context, i) {
                              _currentIndex = i;
                              _currentImage = widget.product.imageList[i];
                              return Image.network(
                                widget.product.imageList[i],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 40.0,
                          left: 10.0,
                          right: 10.0,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: widget.product.imageList
                                    .asMap()
                                    .map((i, e) {
                                      return MapEntry(
                                        i,
                                        AnimatedBar(
                                          animController: _animController,
                                          position: i,
                                          currentIndex: _currentIndex,
                                        ),
                                      );
                                    })
                                    .values
                                    .toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1.5,
                                  vertical: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          child: Container(
                            color: Colors.black,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 26,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 0.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.push_pin_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PostMakeScreen()));
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height / 32,
                          child: Container(
                            color: Colors.black,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 10,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1.5,
                                vertical: 10.0,
                              ),
                              child: UserInfo(user: widget.product.user),
                            ),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2.5,
                          bottom: MediaQuery.of(context).size.height * 0.1,
                          child: Align(
                              alignment: Alignment.center,
                              child: picked
                                  ? Container(
                                      margin: EdgeInsets.symmetric(vertical: 7),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: ClipRRect(
                                        child: MaterialButton(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            shape: CircleBorder(
                                                side: BorderSide(
                                              color: Colors.redAccent,
                                              width: 2,
                                              style: BorderStyle.solid,
                                            )),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            onPressed: () {},
                                            child: CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage:
                                                  NetworkImage(_fixedImage),
                                              backgroundColor:
                                                  Colors.transparent,
                                            )),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.symmetric(vertical: 7),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: ClipRRect(
                                        child: MaterialButton(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            shape: CircleBorder(
                                                side: BorderSide(
                                              color: Colors.redAccent,
                                              width: 2,
                                              style: BorderStyle.solid,
                                            )),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            onPressed: () {
                                              setState(() {
                                                picked = true;
                                                _fixedImage = _currentImage;
                                              });
                                            },
                                            child: Image.asset(
                                                'images/pin@3x.png',
                                                fit: BoxFit.fill,
                                                color: Colors.redAccent)),
                                      ),
                                    )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, imageList) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dx = details.globalPosition.dx;
    final double dy = details.globalPosition.dy;

    // print("dx, dy : ${dx} ${dy}");
    // print("width, height : ${screenWidth} ${screenHeight}");

    if ((dy < screenHeight * 0.0642)) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadImage(image: imageList[_currentIndex]);
        }
      });
    } else if ((dx < screenWidth * 0.42) || (dx > screenWidth * 0.584)) {
      if ((dy < (screenHeight - screenHeight * 0.15)) &&
          (dy > screenHeight * 0.75)) {
        setState(() {
          if (_currentIndex + 1 < imageList.length) {
            _currentIndex += 1;
            _loadImage(image: imageList[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadImage(image: imageList[_currentIndex]);
          }
        });
      }
    }
  }

  void _loadImage({image, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();

    _animController.duration = const Duration(seconds: 5);
    _animController.forward();

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutExpo,
      );
    }
  }
}
