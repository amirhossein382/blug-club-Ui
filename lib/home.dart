import 'package:bulg_club/article.dart';
import 'package:bulg_club/data.dart';
import 'package:bulg_club/gen/assets.gen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = AppDatabase.stories;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 26, 32, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, jonathan!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Assets.img.icons.notification.image(width: 32, height: 32)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 16),
                child: Text(
                  "Explore today's",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              _StoryList(stories: stories),
              const SizedBox(
                height: 14,
              ),
              _CategoryList(),
              _PostList()
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    required this.stories,
  });

  final List stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          padding: const EdgeInsets.fromLTRB(26, 1, 32, 0),
          itemBuilder: (context, index) {
            final storie = stories[index];
            return _StoryItem(storie: storie);
          }),
    );
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem({
    required this.storie,
  });

  // ignore: prefer_typing_uninitialized_variables
  final storie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            storie.isViewed ? _seenBorder() : _normalBorder(),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/img/icons/${storie.iconFileName}",
                width: 24,
                height: 23,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          storie.name,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }

  Widget _normalBorder() {
    return Container(
      height: 68,
      width: 68,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [Color(0xff376AED), Color(0xff49B0E2), Color(0xff9CECFB)],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
        ),
        child: _profile(),
      ),
    );
  }

  Widget _seenBorder() {
    return SizedBox(
      height: 68,
      width: 68,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        color: const Color(0xff7B8BB2),
        dashPattern: const [5, 3],
        radius: const Radius.circular(24),
        padding: const EdgeInsets.all(7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: _profile(),
        ),
      ),
    );
  }

  Widget _profile() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset("assets/img/stories/${storie.imageFileName}"),
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;
    return CarouselSlider.builder(
      itemCount: categories.length,
      itemBuilder: (context, index, realIndex) {
        return _CategoryItem(
          category: categories[realIndex],
          leftItemPadding: realIndex == 0 ? 32 : 8,
          rightItemPadding: realIndex == categories.length - 1 ? 32 : 8,
        );
      },
      options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          viewportFraction: .8,
          aspectRatio: 1.2,
          initialPage: 0,
          enableInfiniteScroll: false,
          padEnds: false,
          enlargeCenterPage: true,
          scrollPhysics: const BouncingScrollPhysics(),
          enlargeStrategy: CenterPageEnlargeStrategy.height
          ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.category,
    required this.leftItemPadding,
    required this.rightItemPadding,
  });
  final double leftItemPadding;
  final double rightItemPadding;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(leftItemPadding, 28, rightItemPadding, 24),
      child: Stack(
        children: [
          Positioned(
            top: 100,
            right: 65,
            left: 65,
            bottom: 0,
            child: Container(
              padding:  EdgeInsets.fromLTRB(leftItemPadding, 32, rightItemPadding, 32),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Color(0xff0D253C),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                      colors: [Color(0xff0D253C), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center)),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(32)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  "assets/img/posts/large/${category.imageFileName}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            left: 32,
            child: Text(
              category.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  final posts = AppDatabase.posts;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 12, 24, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latests news",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "More",
                    style: TextStyle(color: Color(0xff376AED)),
                  ))
            ],
          ),
        ),
        ListView.builder(
          itemCount: posts.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: ((context, index) {
            final post = posts[index];
            return _PostItem(post: post);
          }),
        ),
      ],
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({
    required this.post,
  });

  final PostData post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Article()));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
        height: 141,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Color(0x1a5282FF)),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset("assets/img/posts/small/${post.imageFileName}"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: const Color(0xff376AED)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.hand_thumbsup,
                          size: 16,
                        ),
                        Text(post.likes),
                        const SizedBox(
                          width: 16,
                        ),
                        const Icon(
                          CupertinoIcons.clock,
                          size: 16,
                        ),
                        Text(post.time),
                        const SizedBox(
                          width: 22,
                        ),
                        const Icon(
                          CupertinoIcons.bookmark,
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
