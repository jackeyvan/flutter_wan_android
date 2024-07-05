import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'refresh_controller.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================

abstract class GetRefreshPage<C extends GetRefreshController>
    extends GetView<C> {
  const GetRefreshPage({Key? key}) : super(key: key);

  Widget buildRefreshView({required Widget Function() builder}) {
    return EasyRefresh(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoad,
      header: MaterialHeader(),
      footer: MaterialFooter(),
      canLoadAfterNoMore: controller.enableControlFinishLoad(),
      canRefreshAfterNoMore: controller.enableControlFinishRefresh(),
      // firstRefresh: controller.firstRefresh(),
      child: builder(),
    );
  }

  Widget buildRefreshListView<T>(
      {required GetRefreshController<T> controller,
      required Widget Function(T item, int index) itemBuilder,
      Widget Function(T item, int index)? separatorBuilder,
      Function(T item, int index)? onItemClick,
      ScrollPhysics? physics,
      bool shrinkWrap = false,
      Axis scrollDirection = Axis.vertical}) {
    return buildRefreshView(
        builder: () => buildListView<T>(
            itemBuilder: itemBuilder,
            data: controller.getData(),
            separatorBuilder: separatorBuilder,
            onItemClick: onItemClick,
            physics: physics,
            shrinkWrap: shrinkWrap,
            scrollDirection: scrollDirection));
  }

  Widget buildListView<T>(
      {required Widget Function(T item, int index) itemBuilder,
      required List<T> data,
      Widget Function(T item, int index)? separatorBuilder,
      Function(T item, int index)? onItemClick,
      ScrollPhysics? physics,
      bool shrinkWrap = false,
      Axis scrollDirection = Axis.vertical}) {
    return ListView.separated(
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: const EdgeInsets.all(12),
        scrollDirection: scrollDirection,
        itemBuilder: (ctx, index) => GestureDetector(
              child: itemBuilder.call(data[index], index),
              onTap: () => onItemClick?.call(data[index], index),
            ),
        separatorBuilder: (ctx, index) =>
            separatorBuilder?.call(data[index], index) ?? Container(),
        itemCount: data.length);
  }

  // Widget obx(Widget Function() builder,
  //     {Widget? onLoading,
  //     Widget? onEmpty,
  //     Widget Function(String? error)? onError}) {
  //   return controller.obx((data) => builder.call(),
  //       onError: onError ??
  //           (error) => ErrorPage(msg: error, onRetry: controller.retryRefresh),
  //       onEmpty: onEmpty ?? const EmptyPage(),
  //       onLoading: onLoading ?? const LoadingPage());
  // }
}
