import 'package:bulg_club/article.dart';
import 'package:bulg_club/gen/assets.gen.dart';
import 'package:bulg_club/gen/fonts.gen.dart';
import 'package:bulg_club/home.dart';
import 'package:bulg_club/profile.dart';
import 'package:bulg_club/search.dart';
import 'package:flutter/material.dart';

const homeIndex = 0;
const articleIndex = 1;
const searchIndex = 2;
const profileIndex = 3;
void main() {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.white,
  //     statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarColor: Colors.white,
  //     systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xff0D253C);
    // const Color secondryTextColor = Color(0xff2D4379);
    const Color primaryColor = Color(0xff376AED);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              surface: Colors.white,
              onPrimary: Colors.white,
              onSurface: primaryTextColor,
              background: Color(0xffFBFCFF),
              onBackground: primaryTextColor),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            titleSpacing: 32,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.avenir),
              ),
            ),
          ),
          textTheme: const TextTheme(
              headlineLarge: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: primaryTextColor),
              headlineMedium: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
              headlineSmall: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 18,
                  fontWeight: FontWeight.w200),
              titleLarge: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              titleMedium: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              titleSmall: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              labelLarge: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: primaryTextColor),
              labelSmall: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 10,
                  fontWeight: FontWeight.w700),
              bodyMedium: TextStyle(fontFamily: FontFamily.avenir)),
        ),
        home: const MainSreen());
  }
}

class MainSreen extends StatefulWidget {
  const MainSreen({super.key});

  @override
  State<MainSreen> createState() => _MainSreenState();
}

class _MainSreenState extends State<MainSreen> {
  int selectedPage = homeIndex;
  List history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _articleKey = GlobalKey();
  final GlobalKey<NavigatorState> _screenKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late var map = {
    homeIndex: _homeKey,
    articleIndex: _articleKey,
    searchIndex: _screenKey,
    profileIndex: _profileKey,
  };
  late NavigatorState currentNavState = map[selectedPage]!.currentState!;

  Future onWillPop() async {
    if (currentNavState.canPop()) {
      currentNavState.pop();
      return false;
    } else if (history.isNotEmpty) {
      setState(() {
        selectedPage = history.last;
        history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: selectedPage,
              children: [
                _navigator(_homeKey, homeIndex, const HomeScreen()),
                _navigator(_articleKey, articleIndex, const Article()),
                _navigator(_screenKey, searchIndex, const SearchScreen()),
                _navigator(_profileKey, profileIndex, const Profile()),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: BottomNavigation(
                  selectedPageIndex: selectedPage,
                  onTap: (int index) {
                    setState(() {
                      history.remove(selectedPage);
                      history.add(selectedPage);
                      selectedPage = index;
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedPage != index
        ? const SizedBox()
        : Offstage(
            offstage: selectedPage != index,
            child: Navigator(
              key: key,
              onGenerateRoute: (settings) =>
                  MaterialPageRoute(builder: (context) => child),
            ),
          );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.onTap, required this.selectedPageIndex});
  final Function(int index) onTap;
  final int selectedPageIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: const Color(0xff0D253C).withOpacity(0.3),
                )
              ], color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BottomNavigationItem(
                    image: Assets.img.icons.home.path,
                    title: "Home",
                    onTap: () {
                      onTap(homeIndex);
                    },
                    isActive: selectedPageIndex == homeIndex,
                  ),
                  _BottomNavigationItem(
                    image: Assets.img.icons.articles.path,
                    title: "Articles",
                    onTap: () {
                      onTap(articleIndex);
                    },
                    isActive: selectedPageIndex == articleIndex,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  _BottomNavigationItem(
                    image: Assets.img.icons.search.path,
                    title: "Search",
                    onTap: () {
                      onTap(searchIndex);
                    },
                    isActive: selectedPageIndex == searchIndex,
                  ),
                  _BottomNavigationItem(
                    image: Assets.img.icons.menu.path,
                    title: "Menu",
                    onTap: () {
                      onTap(profileIndex);
                    },
                    isActive: selectedPageIndex == profileIndex,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: const Color(0xff376AED),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.white, width: 3)),
                child: Image.asset(r"assets/img/icons/plus.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    required this.image,
    required this.title,
    required this.onTap,
    required this.isActive,
  });
  final String image;
  final String title;
  final Function() onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 34,
            height: 34,
          ),
          Text(
            title,
            style: themeData.textTheme.labelSmall!.apply(
                color: isActive
                    ? themeData.colorScheme.primary
                    : themeData.textTheme.bodyMedium!.color),
          )
        ],
      ),
    );
  }
}
