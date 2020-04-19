class NewsArticle {
  final String title;
  final String body;
  final String imageUrl;

  NewsArticle(this.title, this.body, this.imageUrl);
}

final List<NewsArticle> newsArticles = [
  NewsArticle(
    '1. Some good news somewhere in world!',
    'Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet.',
    'assets/images/AltoAdventure.png',
  ),
  NewsArticle(
    '2. Some good news somewhere in world!',
    'Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet.',
    'assets/images/AltoAdventure.png',
  ),
  NewsArticle(
    '3. Some good news somewhere in world!',
    'Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet.',
    'assets/images/AltoAdventure.png',
  ),
];
