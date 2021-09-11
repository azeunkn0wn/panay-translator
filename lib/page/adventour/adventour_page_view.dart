import 'package:panay_translator/model/region.dart';
import 'package:panay_translator/page/adventour/adventour_page_item.dart';
import 'package:panay_translator/page/adventour/page_transformer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:panay_translator/utilities/database.dart';
import 'package:panay_translator/utilities/loadhtml.dart';

class AdventourPageView extends StatefulWidget {
  @override
  _AdventourPageViewState createState() => _AdventourPageViewState();
}

class _AdventourPageViewState extends State<AdventourPageView> {
  late Widget background;

  late Future<List<AdventourItems>> getAdventourItems;
  late List<AdventourItems> adventourItems;
  late Widget swappableWidget;
  late int selectedIndex;
  int stackIndex = 0;
  double itemsInfoOpacity = 0.0;
  double itemsOpacity = 1.0;
  late List<Widget> _indexedStackChildren;

  @override
  void initState() {
    getAdventourItems = getadventourItems();
    background = Container();
    swappableWidget = items();
    selectedIndex = 0;
    _indexedStackChildren = [
      items(),
    ];
    super.initState();
  }

  Future<List<AdventourItems>> getadventourItems() async {
    final database = SQLiteDatabaseProvider();

    Map data = await database.getRegionLanguage();
    Map region = data['regions'];
    setState(() {
      adventourItems = [
        AdventourItems(
          region: region[1],
          title: 'ILOILO',
          subtitle: '',
          imageUrl: 'assets/res/adventour/banner/iloilo.jpg',
        ),
        AdventourItems(
          region: region[2],
          title: 'AKLAN',
          subtitle: '',
          imageUrl: 'assets/res/adventour/banner/aklan.jpg',
        ),
        AdventourItems(
          region: region[3],
          title: 'CAPIZ',
          subtitle: '',
          imageUrl: 'assets/res/adventour/banner/capiz.jpg',
        ),
        AdventourItems(
          region: region[4],
          title: 'ANTIQUE',
          subtitle: '',
          imageUrl: 'assets/res/adventour/banner/antique.jpg',
        ),
      ];

      background = Background(
        image: adventourItems[selectedIndex].imageUrl,
        key: ValueKey(selectedIndex),
      );
      _indexedStackChildren = [
        items(),
        itemsInfo(adventourItems[selectedIndex].region)
      ];
    });

    return adventourItems;
  }

  Widget backgroundWidget(String imageUrl) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void switchItems() {
    setState(() {
      itemsInfoOpacity = stackIndex == 1 ? 0 : 1;
      itemsOpacity = stackIndex == 0 ? 0 : 1;
      stackIndex = stackIndex == 1 ? 0 : 1;

      // swappableWidget = itemsInfo(adventourItems[selectedIndex].region);

      _indexedStackChildren = [
        items(),
        itemsInfo(adventourItems[selectedIndex].region)
      ];
    });
  }

  Widget itemsInfo(region) {
    return AnimatedOpacity(
      key: ValueKey(selectedIndex),
      duration: Duration(milliseconds: 1000),
      curve: Curves.decelerate,
      opacity: itemsInfoOpacity,
      child: SafeArea(
        child: SingleChildScrollView(
          child: HtmlLoader(region, page: 'touristspots'),
        ),
      ),
    );
  }

  Widget items() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate,
      opacity: itemsOpacity,
      child: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                    background = Background(
                        image: adventourItems[index].imageUrl,
                        key: ValueKey(index));
                  });
                  _indexedStackChildren = [
                    items(),
                    itemsInfo(adventourItems[selectedIndex].region)
                  ];
                },
                controller: PageController(
                    viewportFraction: 0.85, initialPage: selectedIndex),
                itemCount: adventourItems.length,
                itemBuilder: (context, index) {
                  final item = adventourItems[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);

                  return AdventourPageItem(
                    item: item,
                    pageVisibility: pageVisibility,
                    swapfunction: switchItems,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (stackIndex == 1) {
      switchItems();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: background,
              ),
            ),
            FutureBuilder<List<AdventourItems>>(
              future: getAdventourItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // List<AdventourItems> adventourItems = snapshot.data!;

                  // return AnimatedSwitcher(
                  //   duration: const Duration(milliseconds: 300),
                  //   child: swappableWidget,);
                  return IndexedStack(
                    index: stackIndex,
                    children: _indexedStackChildren,
                  );
                } else {
                  return Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final String image;
  final Key key;
  const Background({required this.image, required this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}

class AdventourItems {
  AdventourItems({
    required this.region,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final Region region;
  final String title;
  final String subtitle;
  final String imageUrl;
}
