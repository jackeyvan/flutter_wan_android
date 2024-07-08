import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/core.dart';
import 'package:get/get.dart';

import 'status/refresh_empty_page.dart';
import 'status/refresh_error_page.dart';
import 'status/refresh_loading_page.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================

abstract class GetRefreshPage<C extends GetRefreshController>
    extends GetView<C> {
  const GetRefreshPage({Key? key}) : super(key: key);

  Widget buildRefreshListView<T>(
      {required GetRefreshController<T> controller,
      required Widget Function(T item, int index) itemBuilder,
      Widget Function(T item, int index)? separatorBuilder,
      Function(T item, int index)? onItemClick,
      ScrollPhysics? physics,
      bool shrinkWrap = false,
      Axis scrollDirection = Axis.vertical}) {
    return buildRefreshView(
        controller: controller,
        builder: () => buildListView<T>(
            itemBuilder: itemBuilder,
            data: controller.getData(),
            separatorBuilder: separatorBuilder,
            onItemClick: onItemClick,
            physics: physics,
            shrinkWrap: shrinkWrap,
            scrollDirection: scrollDirection));
  }

  Widget buildRefreshView(
      {required Widget Function() builder,
      required GetRefreshController controller}) {
    return EasyRefresh(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoad,
      header: const MaterialHeader(),
      footer: const MaterialFooter(),
      canLoadAfterNoMore: controller.enableControlFinishLoad(),
      canRefreshAfterNoMore: controller.enableControlFinishRefresh(),

      // firstRefresh: controller.firstRefresh(),
      child: builder(),
    );
  }

  Widget buildListView<T>(
      {required Widget Function(T item, int index) itemBuilder,
      required List<T> data,
      Widget Function(T item, int index)? separatorBuilder,
      Function(T item, int index)? onItemClick,
      ScrollPhysics? physics = const AlwaysScrollableScrollPhysics(),
      bool shrinkWrap = false,
      Axis scrollDirection = Axis.vertical}) {
    return ListView.separated(
        scrollDirection: scrollDirection,
        itemBuilder: (ctx, index) => InkWell(
              child: itemBuilder.call(data[index], index),
              onTap: () => onItemClick?.call(data[index], index),
            ),
        separatorBuilder: (ctx, index) =>
            separatorBuilder?.call(data[index], index) ?? const SizedBox(),
        itemCount: data.length);
  }

  Widget buildObx(
      {required Widget Function() builder,
      required GetRefreshController controller,
      Widget? onLoading,
      Widget? onEmpty,
      Widget Function(String? error)? onError}) {
    return controller.obx((data) => builder.call(),
        onError: onError ??
            (error) => ErrorPage(msg: error, onRetry: controller.retryRefresh),
        onEmpty: onEmpty ?? const EmptyPage(),
        onLoading: onLoading ?? const LoadingPage());
  }
}
