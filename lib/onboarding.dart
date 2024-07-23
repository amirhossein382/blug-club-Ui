import 'package:bulg_club/auth.dart';
import 'package:bulg_club/data.dart';
import 'package:bulg_club/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController controller = PageController();
  final items = AppDatabase.onBoardingItems;
  int page = 0;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.page!.round() != page) {
        setState(() {
          page = controller.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Assets.img.background.onboarding.image(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(48, 32, 48, 32),
                decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2), blurRadius: 20),
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 190,
                      child: PageView.builder(
                          itemCount: items.length,
                          controller: controller,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return _PageViewItem(item: items[index], themeData: themeData);
                          })),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: controller,
                          count: items.length,
                          effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              dotColor:
                                  themeData.colorScheme.primary.withOpacity(.2),
                              activeDotColor: themeData.colorScheme.primary),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (page == items.length - 1) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Authentication(),
                                ),
                              );
                            } else {
                              controller.animateToPage(++page,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.bounceIn);
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => themeData.colorScheme.primary),
                            iconColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            minimumSize:
                                MaterialStateProperty.all(const Size(88, 60)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: Icon(page == items.length - 1
                              ? CupertinoIcons.check_mark
                              : CupertinoIcons.arrow_right),
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

class _PageViewItem extends StatelessWidget {
  const _PageViewItem({
    required this.item,
    required this.themeData,
  });

  final item;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: themeData.textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          item.description,
          style: themeData.textTheme.bodyMedium!
              .apply(fontSizeDelta: 1),
        )
      ],
    );
  }
}
