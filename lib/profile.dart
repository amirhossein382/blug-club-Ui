import 'package:bulg_club/data.dart';
import 'package:bulg_club/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final posts = AppDatabase.posts;
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: themeData.colorScheme.background.withOpacity(0),
            title: const Text("Profile"),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate.fixed([
            Column(
              children: [
                _ProfileContainer(themeData: themeData),
                _PostList(themeData: themeData, posts: posts)
              ],
            )
          ]))
        ],
      ),
    ));
  }
}

class _ProfileContainer extends StatelessWidget {
  const _ProfileContainer({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            right: 96,
            left: 96,
            child: Container(
              height: 48,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 30,
                    color: themeData.colorScheme.onBackground
                        .withOpacity(.8))
              ]),
            )),
        Container(
          // height: 350,
          margin: const EdgeInsets.fromLTRB(32, 32, 32, 45),
          decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  color: themeData.colorScheme.onBackground
                      .withOpacity(.2),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                colors: [
                                  Color(0xff376AED),
                                  Color(0xff49B0E2),
                                  Color(0xff9CECFB)
                                ]),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(32)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Assets.img.stories.story9
                              .image(height: 64, width: 64)),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "@joviedan",
                          style: themeData.textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Jovi Daniel",
                          style: themeData.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("UX Designer",
                            style: themeData.textTheme.titleSmall!
                                .apply(
                                    color: themeData
                                        .colorScheme.primary))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "About me",
                  style: themeData.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Madison Blackstone is a director of user experience design, with experience managing global teams.",
                  style: themeData.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 18,
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 66,
          left: 66,
          child: Container(
            height: 65,
            decoration: BoxDecoration(
                color: themeData.colorScheme.primary,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                AccountStatusItem(
                  themeData: themeData,
                  title: "Post",
                  count: "52",
                ),
                AccountStatusItem(
                  themeData: themeData,
                  title: "Followings",
                  count: "250",
                ),
                AccountStatusItem(
                  themeData: themeData,
                  title: "Followers",
                  count: "4.1K",
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({
    required this.themeData,
    required this.posts,
  });

  final ThemeData themeData;
  final List<PostData> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 16, 16, 32),
      margin: const EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "My Posts",
                style: themeData.textTheme.titleLarge,
              )),
              IconButton(onPressed: () {}, icon: Assets.img.icons.grid.svg()),
              IconButton(onPressed: () {}, icon: Assets.img.icons.table.svg())
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          _PostItem(posts: posts)
        ],
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({
    required this.posts,
  });

  final List<PostData> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: ((context, index) {
          final post = posts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 32),
            height: 141,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                      "assets/img/posts/small/${post.imageFileName}"),
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
          );
        }));
  }
}

class AccountStatusItem extends StatelessWidget {
  const AccountStatusItem({
    super.key,
    required this.themeData,
    required this.title,
    required this.count,
  });

  final ThemeData themeData;
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: themeData.textTheme.titleLarge!
                .apply(color: themeData.colorScheme.onPrimary),
          ),
          Text(
            title,
            style: themeData.textTheme.bodyMedium!
                .apply(color: themeData.colorScheme.onPrimary),
          )
        ],
      ),
    );
  }
}
