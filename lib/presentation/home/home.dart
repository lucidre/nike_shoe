import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nike_shoe/constants/numbers.dart';
import 'package:nike_shoe/constants/strings.dart';
import 'package:nike_shoe/constants/style.dart';
import 'package:nike_shoe/controller/shoe_controller.dart';
import 'package:nike_shoe/models/shoe.dart';
import 'package:nike_shoe/routing/app_router.gr.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: buildAppBar(),
      body: Container(
        color: darkColor,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(kDefaultMargin),
                child: Column(children: const [
                  _TopHeader(),
                  SizedBox(
                    height: kDefaultMargin,
                  ),
                  Expanded(
                    child: _HomeBody(),
                  ),
                  SizedBox(
                    height: kDefaultMargin,
                  ),
                ]),
              ),
            ),
            const _BottomAppBar(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: darkColor,
      leading: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: kDefaultMargin / 2),
        child: Image.asset(
          logoLocation,
          width: 40,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_rounded),
          color: lightColor,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_bag_outlined),
          color: lightColor,
        )
      ],
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  final _pageController =
      PageController(initialPage: 0, viewportFraction: 0.95);
  final _scrollNotifier = ValueNotifier(0.0);

  void _listener() {
    _scrollNotifier.value = _pageController.page ?? 0;
  }

  @override
  void initState() {
    _pageController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!.copyWith(
      color: darkColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
    return GetBuilder<ShoeController>(builder: (controller) {
      return ValueListenableBuilder<double>(
        valueListenable: _scrollNotifier,
        builder: (_, scroll, __) => PageView.builder(
          controller: _pageController,
          onPageChanged: (position) {
            controller.updateColor(allShoes[position].color[0]);
          },
          itemCount: allShoes.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            final shoe = allShoes[index];
            final double percentLeft = (-scroll + index + 1).clamp(0.0, 1.0);
            final double percentRight = (scroll - index + 1).clamp(0.0, 1.0);
            final double percentScaleLeft =
                pow((-scroll + index + 1).clamp(0.0, 1.0), 0.5).toDouble();
            final double percentScaleRight =
                pow((scroll - index + 1).clamp(0.0, 1.0), 0.5).toDouble();
            final scale =
                percentRight < 1 ? percentScaleRight : percentScaleLeft;
            debugPrint(
                '$percentLeft   $percentRight   $percentScaleLeft   $percentScaleRight   $scale');
            return InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                context.router.navigate(DetailsRoute(shoe: shoe));
              },
              child: Opacity(
                  opacity: percentRight < 1 ? percentRight : percentLeft,
                  child: Stack(
                    children: [
                      Transform.scale(
                        scale: scale,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(kDefaultMargin),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefaultMargin)),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: double.infinity,
                                    ),
                                    Text(
                                      shoe.name,
                                      style: bodyText1,
                                    ),
                                    const SizedBox(
                                      height: kDefaultMargin / 2,
                                    ),
                                    Text(
                                      shoe.longName,
                                      style: bodyText1,
                                    ),
                                    const SizedBox(
                                      height: kDefaultMargin / 2,
                                    ),
                                    Text(
                                      '\$ ${shoe.price}',
                                      style: bodyText1,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          shoe.backgroundName.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: bodyText1.copyWith(
                                              fontSize: 80,
                                              color: shoe.color[0]
                                                  .withOpacity(.2)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding:
                                      const EdgeInsets.all(kDefaultPadding),
                                  decoration: BoxDecoration(
                                    color: shoe.color[0],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(kDefaultMargin),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: darkColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 40,
                        child: Hero(
                          tag: shoe.image[0],
                          child: Transform.scale(
                            scale: 1.5 * scale,
                            child: Transform.rotate(
                              angle: -pi / 6,
                              child: Image.asset(
                                shoe.image[0],
                                width: 250,
                                height: 250,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      );
    });
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ShoeController>(builder: (controller) {
      final textTheme = Theme.of(context).textTheme;
      final bodyText1 = textTheme.bodyText1;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            Text(
              'BasketBalll',
              style: bodyText1?.copyWith(color: controller.currentColor),
            ),
            const SizedBox(
              width: kDefaultMargin / 2,
            ),
            Text(
              'Running',
              style: bodyText1,
            ),
            const SizedBox(
              width: kDefaultMargin / 2,
            ),
            Text(
              'Training',
              style: bodyText1,
            ),
          ],
        ),
      );
    });
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ShoeController>(builder: (controller) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: controller.currentColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kDefaultMargin),
              topRight: Radius.circular(kDefaultMargin)),
        ),
        padding: const EdgeInsets.only(
            top: kDefaultMargin,
            bottom: kDefaultMargin,
            left: kDefaultMargin * 1.5,
            right: kDefaultMargin * 1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.home_filled,
              color: darkColor,
              size: 20,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultMargin * 1.5),
                color: darkColor,
              ),
              child: Icon(
                Icons.camera_sharp,
                color: controller.currentColor,
                size: 22,
              ),
            ),
            const Icon(
              Icons.person_rounded,
              color: darkColor,
              size: 20,
            )
          ],
        ),
      );
    });
  }
}
