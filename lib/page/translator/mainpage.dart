import 'package:flutter/material.dart';
import 'package:panay_translator/drawer.dart';
import 'package:panay_translator/page/translator/favorites.dart';
import 'package:panay_translator/page/translator/translator.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.selectedPageIndex = 0}) : super(key: key);
  final int selectedPageIndex;
  final GlobalKey key = GlobalKey();
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late PageController _pageController;
  late int _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.selectedPageIndex;
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  void changePage(value) {
    setState(() {
      _selectedPageIndex = value;
    });
    _pageController.jumpToPage(_selectedPageIndex);
  }

  _onTapBar(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
    changePage(_selectedPageIndex);
  }

  List<String> _titleList = ['Translator', 'Favorites'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleList[_selectedPageIndex])),
      drawer: MainDrawer(
          parentKey: widget.key,
          currentPage: '/' + _titleList[_selectedPageIndex].toLowerCase()),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapBar,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.portrait), label: 'Translator'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_rounded), label: 'Favorites'),
        ],
      ),
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            _selectedPageIndex = page;
          });
        },
        controller: _pageController,
        children: [
          Translator(),
          FavoritesPage(),
        ],
      ),
    );
  }
}
