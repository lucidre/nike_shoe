import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_shoe/constants/numbers.dart';
import 'package:nike_shoe/constants/style.dart';
import 'package:nike_shoe/controller/details_controller.dart';
import 'package:nike_shoe/models/shoe.dart';

const duration = Duration(milliseconds: 300);

class DetailsPage extends StatelessWidget {
  final Shoe shoe;
  const DetailsPage({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
        init: DetailsController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                buildCircleImage(),
                buildBody(
                  context,
                ),
              ],
            ),
          );
        });
  }

  Widget buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!.copyWith(
      color: lightColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    return SizedBox(
      height: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildAppBar(context),
        const SizedBox(
          height: kDefaultMargin / 2,
        ),
        Expanded(child: _DetailsImageBody(shoe: shoe)),
        const SizedBox(
          height: kDefaultMargin / 2,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: kDefaultPadding, right: kDefaultPadding),
          child: Text(
            shoe.name,
            style: bodyText1,
          ),
        ),
        const SizedBox(
          height: kDefaultMargin / 4,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: kDefaultPadding, right: kDefaultPadding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  shoe.longName,
                  style: bodyText1,
                ),
              ),
              Text(
                '\$ ${shoe.price}',
                style: bodyText1,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: kDefaultMargin,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: kDefaultPadding, right: kDefaultPadding),
          child: Text(
            'SIZE',
            style: bodyText1,
          ),
        ),
        const SizedBox(
          height: kDefaultMargin / 2,
        ),
        buildSize(),
        const SizedBox(
          height: kDefaultMargin * 2,
        ),
        buildBottomBar(bodyText1),
        const SizedBox(
          height: kDefaultMargin * 1.5,
        ),
      ]),
    );
  }

  Padding buildBottomBar(TextStyle bodyText1) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
      child: GetX<DetailsController>(builder: (controller) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Color',
                    style: bodyText1,
                  ),
                  const SizedBox(
                    height: kDefaultMargin / 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: shoe.color
                        .map(
                          (colorItem) => _DetailShoeColorItem(
                            color: colorItem,
                            isSelected: shoe.color.indexOf(colorItem) ==
                                controller.index,
                            onPressed: () => controller.updateIndex(
                              shoe.color.indexOf(colorItem),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            AnimatedContainer(
                duration: duration,
                padding: const EdgeInsets.only(
                    top: kDefaultPadding / 2,
                    bottom: kDefaultPadding / 2,
                    left: kDefaultPadding,
                    right: kDefaultPadding),
                decoration: BoxDecoration(
                  color: shoe.color[controller.index],
                  borderRadius: BorderRadius.circular(kDefaultMargin / 4),
                ),
                child: Text(
                  'BUY',
                  style: bodyText1.copyWith(color: darkColor),
                )),
          ],
        );
      }),
    );
  }

  Widget buildSize() {
    return GetX<DetailsController>(builder: (controller) {
      Color itemColor(int index) {
        return controller.sizeIndex == index
            ? shoe.color[controller.index]
            : lightColor;
      }

      return Padding(
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: Row(
          children: [
            _DetailsSizeItem(
              text: '7',
              onPressed: () => controller.updateSize(1),
              color: itemColor(1),
            ),
            _DetailsSizeItem(
              text: '7.5',
              onPressed: () => controller.updateSize(2),
              color: itemColor(2),
            ),
            _DetailsSizeItem(
              text: '8',
              onPressed: () => controller.updateSize(3),
              color: itemColor(3),
            ),
            _DetailsSizeItem(
              text: '9',
              onPressed: () => controller.updateSize(4),
              color: itemColor(4),
            ),
            _DetailsSizeItem(
              text: '10',
              onPressed: () => controller.updateSize(5),
              color: itemColor(5),
            ),
          ],
        ),
      );
    });
  }

  Positioned buildCircleImage() {
    return Positioned(
      top: -150,
      right: -250,
      child: GetX<DetailsController>(builder: (controller) {
        final index = controller.index;
        return AnimatedContainer(
          duration: duration,
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            color: shoe.color[index],
            borderRadius: BorderRadius.circular(400),
          ),
        );
      }),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            context.router.pop();
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 14,
              color: darkColor,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_rounded,
              color: lightColor,
            ))
      ],
    );
  }
}

class _DetailShoeColorItem extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;
  const _DetailShoeColorItem({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: AnimatedContainer(
        duration: duration,
        width: 24,
        margin: const EdgeInsets.only(right: kDefaultMargin / 4),
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? lightColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _DetailsSizeItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  const _DetailsSizeItem({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!.copyWith(
      color: darkColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: AnimatedContainer(
        duration: duration,
        width: 40,
        margin: const EdgeInsets.only(right: kDefaultMargin / 2),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kDefaultMargin / 4),
        ),
        child: Text(
          text,
          style: bodyText1,
        ),
      ),
    );
  }
}

class _DetailsImageBody extends StatefulWidget {
  final Shoe shoe;
  const _DetailsImageBody({Key? key, required this.shoe}) : super(key: key);

  @override
  State<_DetailsImageBody> createState() => _DetailsImageBodyState();
}

class _DetailsImageBodyState extends State<_DetailsImageBody> {
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
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            widget.shoe.backgroundName.toUpperCase(),
            textAlign: TextAlign.center,
            style: bodyText1.copyWith(
              fontSize: 80,
              fontWeight: FontWeight.w800,
              color: lightColor,
            ),
          ),
        ),
        Center(
          child: buildShoeImage(),
        ),
      ],
    );
  }

  Widget buildShoeImage() {
    return GetBuilder<DetailsController>(builder: (controller) {
      return ValueListenableBuilder<double>(
        valueListenable: controller.scrollNotifier,
        builder: (_, scroll, __) => PageView.builder(
          controller: controller.pageController,
          itemCount: widget.shoe.image.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final image = widget.shoe.image[index];
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
            return Hero(
              tag: image,
              child: Opacity(
                  opacity: percentRight < 1 ? percentRight : percentLeft,
                  child: Transform.rotate(
                    angle: -pi / 6,
                    child: Transform.scale(
                      scale: 1.2 * scale,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        image,
                        width: 400 /* * controller.sizeIndex / 5 */,
                        height: 400,
                      ),
                    ),
                  )),
            );
          },
        ),
      );
    });
  }
}
