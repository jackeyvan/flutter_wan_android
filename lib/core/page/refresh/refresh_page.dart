import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';

abstract class GetRefreshListPage<C extends GetRefreshListController>
    extends BasePage<C> {
  const GetRefreshListPage({super.key});

  /// 生成带有ListView的Refresh页面
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

  /// 生成原始Refresh页面
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
      child: builder(controller.getData() ?? []),
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
            separatorBuilder?.call(data[index], index) ??
            const SizedBox.shrink(),
        itemCount: data.length);
  }
}
