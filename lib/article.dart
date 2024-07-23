import 'package:bulg_club/gen/assets.gen.dart';
import 'package:bulg_club/gen/fonts.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  const Article({super.key});

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          showSnackBar(context, "Post liked");
        },
        child: Container(
          width: 111,
          height: 48,
          decoration: BoxDecoration(
              color: themeData.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 12,
                    color: themeData.colorScheme.primary,
                    offset: const Offset(0, 4))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.img.icons.thumbs.svg(),
              const SizedBox(
                width: 8,
              ),
              Text(
                "2.1k",
                style: TextStyle(
                    color: themeData.colorScheme.onPrimary,
                    fontFamily: FontFamily.avenir,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
              SliverAppBar(
                title: const Text("Article"),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded)),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 16, 32),
                      child: Column(
                        children: [
                          Text("Four Things Every Woman Needs To Now",
                              style: themeData.textTheme.headlineLarge),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Assets.img.stories.story9
                                    .image(height: 48, width: 48),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Richard Gervain",
                                        style: themeData.textTheme.labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      const Text("2m ago")
                                    ]),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(CupertinoIcons.share),
                                color: themeData.colorScheme.primary,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(CupertinoIcons.bookmark),
                                color: themeData.colorScheme.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      child: Assets.img.background.singlePost.image(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Text(
                            'A man’s sexuality is never your mind responsibility.',
                            style: themeData.textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.',
                            style: themeData.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ]))
            ]),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 95,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        themeData.colorScheme.surface,
                        themeData.colorScheme.surface.withAlpha(0),
                      ])),
                ))
          ],
        ),
      ),
    );
  }
}
