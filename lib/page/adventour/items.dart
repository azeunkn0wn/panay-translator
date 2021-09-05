class AdventourItems {
  AdventourItems({
    required this.regionID,
    required this.title,
    required this.category,
    required this.imageUrl,
  });

  final int regionID;
  final String title;
  final String category;
  final String imageUrl;
}

final adventourItems = <AdventourItems>[
  new AdventourItems(
    regionID: 1,
    title: 'We might have the best team spirit ever.',
    category: 'ILOILO',
    imageUrl: 'assets/res/adventour/banner/iloilo.jpg',
  ),
  new AdventourItems(
    regionID: 2,
    title: 'Writing things together is what we do best!',
    category: 'AKLAN',
    imageUrl: 'assets/res/adventour/banner/aklan.jpg',
  ),
  new AdventourItems(
    regionID: 3,
    title: 'Occasionally wearing pants is a good idea.',
    category: 'CAPIZ',
    imageUrl: 'assets/res/adventour/banner/capiz.jpg',
  ),
  new AdventourItems(
    regionID: 4,
    title: 'blahblah blahblah blah',
    category: 'ANTIQUE',
    imageUrl: 'assets/res/adventour/banner/antique.jpg',
  ),
];
