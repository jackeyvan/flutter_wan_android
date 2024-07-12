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

  @override
  Widget build(BuildContext context) {
    dependencies();
    return buildObx(builder: buildRefresh);
  }

  /// 未实现的方法，子类可以用这个方法绑定Controller
  /// 或者做一些初始化工作，但是注意：页面每次Build都会调用
  void dependencies() {}

  /// 子类重写，填充具体的页面
  Widget buildRefresh();

  /// 默认的加载页
  Widget buildLoadingPage() => const LoadingPage();

  /// 默认的空页面
  Widget buildEmptyPage() => const EmptyPage();

  /// 默认的错误展示页面
  Widget buildErrorPage(String? error) =>
      ErrorPage(msg: error, onRetry: controller.retryRefresh);

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
            separatorBuilder?.call(data[index], index) ??
            const SizedBox.shrink(),
        itemCount: data.length);
  }

  Widget buildObx(
      {required Widget Function() builder,
      Widget? onLoading,
      Widget? onEmpty,
      Widget Function(String? error)? onError}) {
    return controller.obx((data) => builder.call(),
        onError: onError ?? (error) => buildErrorPage(error),
        onEmpty: onEmpty ?? buildEmptyPage(),
        onLoading: onLoading ?? buildLoadingPage());
  }
}
