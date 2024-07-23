import 'package:bulg_club/article.dart';
import 'package:bulg_club/gen/assets.gen.dart';
import 'package:bulg_club/gen/fonts.gen.dart';
import 'package:bulg_club/home.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  int currentPage = 0;
  final PageController _controllerPage = PageController();

  @override
  void initState() {
    super.initState();
    _controllerPage.addListener(() {
      if (_controllerPage.page!.round() != currentPage) {
        setState(() {
          currentPage = _controllerPage.page!.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    List pageViewsList = [
      _LoginView(themeData: themeData),
      _SignUpView(themeData: themeData)
    ];
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
            child: Assets.img.icons.logo.svg(width: 120),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeData.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (currentPage == 1) {
                                _controllerPage.animateToPage(--currentPage,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              }
                            });
                          },
                          child: Text(
                            "LOGIN",
                            style: themeData.textTheme.titleLarge!.copyWith(
                                color: currentPage == 0
                                    ? Colors.white
                                    : Colors.white.withOpacity(.5)),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (currentPage == 0) {
                                _controllerPage.animateToPage(++currentPage,
                                    duration: const Duration(microseconds: 500),
                                    curve: Curves.elasticOut);
                              }
                            });
                          },
                          child: Text("SING UP",
                              style: themeData.textTheme.titleLarge!.copyWith(
                                  color: currentPage == 1
                                      ? Colors.white
                                      : Colors.white.withOpacity(.5))),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: PageView.builder(
                            itemCount: 2,
                            controller: _controllerPage,
                            itemBuilder: (context, index) {
                              return pageViewsList[index];
                            })),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back!",
              style: themeData.textTheme.headlineLarge!.copyWith(fontSize: 32),
            ),
            const SizedBox(height: 12),
            Text(
              "Sign in with your account",
              style: themeData.textTheme.bodyLarge!
                  .copyWith(fontFamily: FontFamily.avenir),
            ),
            const SizedBox(
              height: 32,
            ),
            const _UsernameTextField(),
            _PasswordTextField(themeData: themeData),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Article()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => themeData.colorScheme.primary),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 60)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                    fontFamily: FontFamily.avenir,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Forgot your password?"),
                  const SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: () {}, child: const Text("Reset here"))
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Center(
                child: Text(
              "OR SIGN IN WITH",
              style: TextStyle(
                  letterSpacing: 2,
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w500),
            )),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.img.icons.google.image(height: 42),
                const SizedBox(
                  width: 32,
                ),
                Assets.img.icons.facebook.image(height: 42),
                const SizedBox(
                  width: 32,
                ),
                Assets.img.icons.twitter.image(height: 42),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView({
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome here!",
              style: themeData.textTheme.headlineLarge!.copyWith(fontSize: 32),
            ),
            const SizedBox(height: 12),
            Text(
              "Sign up with your account",
              style: themeData.textTheme.bodyLarge!
                  .copyWith(fontFamily: FontFamily.avenir),
            ),
            const SizedBox(
              height: 32,
            ),
            const _UsernameTextField(),
            _PasswordTextField(themeData: themeData),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => themeData.colorScheme.primary),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 60)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Text(
                "SIGN UP",
                style: TextStyle(
                    fontFamily: FontFamily.avenir,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(
              height: 32,
            ),
            const Center(
                child: Text(
              "OR SIGN UP WITH",
              style: TextStyle(
                  letterSpacing: 2,
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w500),
            )),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.img.icons.google.image(height: 42),
                const SizedBox(
                  width: 32,
                ),
                Assets.img.icons.facebook.image(height: 42),
                const SizedBox(
                  width: 32,
                ),
                Assets.img.icons.twitter.image(height: 42),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(label: Text("username")),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obSecureStateDefault = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obSecureStateDefault,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        label: const Text("password"),
        suffix: InkWell(
          onTap: () {
            setState(() {
              obSecureStateDefault = !obSecureStateDefault;
            });
          },
          child: Text(
            obSecureStateDefault ? "show" : "hide",
            style: TextStyle(
                fontFamily: FontFamily.avenir,
                fontSize: 14,
                color: widget.themeData.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
