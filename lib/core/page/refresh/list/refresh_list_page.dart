import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_controller.dart';
import 'package:flutter_wan_android/core/page/refresh/status/default_empty_page.dart';
import 'package:flutter_wan_android/core/page/refresh/status/default_error_page.dart';
import 'package:flutter_wan_android/core/page/refresh/status/default_loading_page.dart';
import 'package:get/get.dart';

abstract class GetRefreshListPage<C extends GetRefreshListController>
    extends GetView<C> {
  const GetRefreshListPage({super.key});

  Widget buildRefreshListView<T>(
      {required Widget Function(T item, int index) itemBuilder,
      Widget Function(T item, int index)? separatorBuilder,
      Function(T item, int index)? onItemClick,
      ScrollPhysics? physics,
      bool shrinkWrap = false,
      EdgeInsetsGeometry? padding,
      Axis scrollDirection = Axis.vertical}) {
    return buildRefreshView<T>(
        builder: (data) => buildListView<T>(
            itemBuilder: itemBuilder,
            data: data,
            padding: padding,
            separatorBuilder: separatorBuilder,
            onItemClick: onItemClick,
            physics: physics,
            shrinkWrap: shrinkWrap,
            scrollDirection: scrollDirection));
  }

  Widget buildRefreshView<T>({required Widget Function(List<T> data) builder}) {
    return EasyRefresh(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoad,
      header: const MaterialHeader(),
      footer: const MaterialFooter(),
      canLoadAfterNoMore: controller.enableControlFinishLoad(),
      canRefreshAfterNoMore: controller.enableControlFinishRefresh(),
      // firstRefresh: controller.firstRefresh(),
      child: builder(controller.getData().map((e) => e as T).toList()),
    );
  }

  Widget buildListView<T>(
      {required Widget Function(T item, int index) itemBuilder,
      required List<T> data,
      Widget Function(T item, int index)? separatorBuilder,
      Function(T item, int index)? onItemClick,
      ScrollPhysics? physics = const AlwaysScrollableScrollPhysics(),
      bool shrinkWrap = false,
      EdgeInsetsGeometry? padding,
      Axis scrollDirection = Axis.vertical}) {
    return ListView.separated(
        padding: padding,
        scrollDirection: scrollDirection,
        itemBuilder: (ctx, index) {
          if (onItemClick == null) {
            return itemBuilder.call(data[index], index);
          } else {
            return InkWell(
              child: itemBuilder.call(data[index], index),
              onTap: () => onItemClick.call(data[index], index),
            );
          }
        },
        separatorBuilder: (ctx, index) =>
            separatorBuilder?.call(data[index], index) ?? const SizedBox(),
        itemCount: data.length);
  }

  Widget buildObx(
      {required Widget Function() builder,
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
