import 'package:panay_translator/page/adventour/items.dart';
import 'package:panay_translator/page/adventour/adventour_page_item.dart';
import 'package:panay_translator/page/adventour/page_transformer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

class AdventourPageView extends StatefulWidget {
  @override
  _AdventourPageViewState createState() => _AdventourPageViewState();
}

class _AdventourPageViewState extends State<AdventourPageView> {
  late Widget background;
  @override
  void initState() {
    background = Background(
      image: adventourItems[0].imageUrl,
      key: ValueKey(0),
    );
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          child: background,
        ),
      ),
      Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    background = Background(
                        image: adventourItems[index].imageUrl,
                        key: ValueKey(index));
                  });
                },
                controller: PageController(viewportFraction: 0.85),
                itemCount: adventourItems.length,
                itemBuilder: (context, index) {
                  final item = adventourItems[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);

                  return AdventourPageItem(
                    item: item,
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          ),
        ),
      ),
    ]));
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
