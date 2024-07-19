import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/entity/user_entity.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';

class DrawerPage extends BasePage {
  static const _imgHeight = 96.0;
  static const _expandedHeight = 120.0;

  const DrawerPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    final themeData = Theme.of(context);
    return EasyRefresh(
      header: buildRefreshHeader(themeData),
      onRefresh: () {},
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: themeData.colorScheme.primary,
            foregroundColor: themeData.colorScheme.onPrimary,
            expandedHeight: _expandedHeight,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                getNickname(),
                style: TextStyle(color: themeData.colorScheme.onPrimary),
              ),
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 18),
            ),
          ),
          const HeaderLocator.sliver(paintExtent: 80),
          SliverToBoxAdapter(
            child: Card(
              // elevation: 0,
              margin: const EdgeInsets.only(top: 48, left: 16, right: 16),
              color: themeData.colorScheme.primaryContainer,
              // clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.color_lens_outlined),
                    title: const Text('主题'),
                    onTap: () => Routes.toNamed(Routes.themeChose),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: const Text('语言'),
                    onTap: () => Routes.toNamed(Routes.language),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('登出'),
                    onTap: () => Routes.toNamed(Routes.language),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BuilderHeader buildRefreshHeader(ThemeData themeData) {
    return BuilderHeader(
      clamping: false,
      position: IndicatorPosition.locator,
      triggerOffset: 100000,
      notifyWhenInvisible: true,
      builder: (context, state) {
        const expandedExtent = _expandedHeight - kToolbarHeight;
        final pixels = state.notifier.position.pixels;
        final height = state.offset + _imgHeight;
        final clipEndHeight = pixels < expandedExtent
            ? _imgHeight
            : math.max(0.0, _imgHeight - pixels + expandedExtent);
        final imgHeight = pixels < expandedExtent
            ? _imgHeight
            : math.max(0.0, _imgHeight - (pixels - expandedExtent));
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: _TrapezoidClipper(
                height: height,
                clipStartHeight: 0.0,
                clipEndHeight: clipEndHeight,
              ),
              child: Container(
                height: height,
                width: double.infinity,
                color: themeData.colorScheme.primary,
              ),
            ),
            Positioned(
              top: -1,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: _FillLineClipper(imgHeight),
                child: Container(
                  height: 2,
                  width: double.infinity,
                  color: themeData.colorScheme.primary,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/user_head.jpg",
                  height: imgHeight,
                  width: imgHeight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String getNickname() {
    final user = User.getUser();
    return user != null ? user.nickname ?? "" : "请登录";
  }
}

class _TrapezoidClipper extends CustomClipper<Path> {
  final double height;
  final double clipStartHeight;
  final double clipEndHeight;

  _TrapezoidClipper({
    required this.height,
    required this.clipStartHeight,
    required this.clipEndHeight,
  });

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height - clipEndHeight);
    path.lineTo(0, height - clipStartHeight);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TrapezoidClipper oldClipper) {
    return oldClipper.height != height ||
        oldClipper.clipStartHeight != clipStartHeight ||
        oldClipper.clipEndHeight != clipEndHeight;
  }
}

class _FillLineClipper extends CustomClipper<Path> {
  final double imgHeight;

  _FillLineClipper(this.imgHeight);

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height / 2);
    path.lineTo(0, height / 2 + imgHeight / 2);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _FillLineClipper oldClipper) {
    return oldClipper.imgHeight != imgHeight;
  }
}
