import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:card_x_user/ui/pages/card/widgets/card_item.dart';
import 'package:card_x_user/ui/pages/card_profile_user.dart';
import 'package:flutter/material.dart';

/*
class SnapSell extends StatefulWidget {
  @override
  _SnapSellState createState() => _SnapSellState();
}

class _SnapSellState extends State<SnapSell> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentIndex = pageController.page.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[
          CreateACardUi(),
          AddCard(),
          CardProfileUser(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(.1),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          pageController.animateToPage(
            value,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 400),
          );
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Shop")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), title: Text("Add")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
        ],
      ),
    );
  }
}*/
