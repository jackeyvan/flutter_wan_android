import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_wan_android/core/widgets/default_dialog.dart';
import 'package:get/get.dart';

abstract class GetRefreshListController<T> extends GetxController
    with StateMixin<List<T>> {
  EasyRefreshController refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  /// 分页的页数
  int initPage;
  int pageSize;
  int page;

  GetRefreshListController({this.initPage = 0, this.pageSize = 20})
      : page = initPage;

  @override
  void onReady() {
    /// 如果页面一进来就要展示刷新头部，只调用callRefresh
    if (firstRefresh()) {
      startRefresh();
    } else {
      onRefresh();
    }
  }

  /// 刷新数据
  Future<void> onRefresh() async {
    loadData(page).then((result) {
      if (result.isNotEmpty) {
        print("-----> 加载成功了  success ${result}");

        /// 更新界面
        change(result, status: RxStatus.success());
      } else {
        change(result, status: RxStatus.empty());
      }

      /// 刷新完成，这里要注意一定是先展示成功的页面，加载EasyRefresh控件
      /// 再调用RefreshController的方法才有用，不然会报错。
      refreshController.finishRefresh();

      /// 重置页码
      page = initPage;

      /// 刷新的时候，没有更多数据需要去掉上拉加载，没有有更多数据则要重置加载状态
      // if (noMore) {
      //   refreshController.finishLoad();
      // }
    }).onError((error, stack) {
      print("---------> 发生了一场 ${error}");

      /// 如果有数据则提示吐司，如果没有数据则展示错误图
      if (getData().isNotEmpty) {
        /// TODO 提示一个吐司，或者不提示
        ///
      } else {
        change(null, status: RxStatus.error(error?.toString()));
      }
    });
  }

  /// 加载更多
  Future<void> onLoad() async {
    print("------> onLoad");
    var result = await loadData(page);
    if (result.isNotEmpty) {
      /// 更新页码
      page += 1;

      addData(result);

      /// 更新界面
      change(getData(), status: RxStatus.success());
    }

    /// 加载完成
    refreshController.finishLoad();
  }

  /// 加载数据的方法，子类去实现
  Future<List<T>> loadData(int page);

  // /// 数据加载
  // void _loadData(bool isRefresh) async {
  //   loadData(page).then((data) {
  //     var noMore = data.length < pageSize;

  //   }).catchError((e) {
  //     if (isRefresh) {
  //       /// 如果没有数据就展示错误视图，如有有数据就提示吐司
  //       if (getData().isNotEmpty) {
  //         // Toast.show(e.toString());
  //       } else {
  //         // showErrorPage(msg: e.toString());
  //         change(null, status: RxStatus.error(e.toString()));
  //       }
  //
  //       /// 结束刷新状态
  //       refreshController.finishRefresh();
  //     } else {
  //       // Toast.show(e.toString());
  //
  //       /// 结束加载状态
  //       refreshController.finishLoad();
  //     }
  //   });
  // }

  /// 获取数据
  List<T> getData() {
    return value ?? [];
  }

  /// 添加数据
  void addData(List<T>? data) {
    if (data != null && data.isNotEmpty) {
      getData().addAll(data);
    }
  }

  /// 设置数据
  void setData(List<T>? data) {
    getData().clear();
    addData(data);
  }

  /// 重新刷新
  void retryRefresh() {
    change(null, status: RxStatus.loading());
    onRefresh();
  }

  /// 主动刷新
  void startRefresh() {
    refreshController.callRefresh();
  }

  /// 显示加载弹窗
  void showLoadingDialog() {
    LoadingDialog.show();
  }

  /// 隐藏加载弹窗
  void dismissLoadingDialog() {
    LoadingDialog.dismiss();
  }

  /// 第一次进入页面刷新
  bool firstRefresh() => false;

  /// 是否可以操作结束加载
  bool enableControlFinishLoad() => true;

  /// 是否可以操作结束刷新
  bool enableControlFinishRefresh() => true;

  /// 销毁时刷新控件一起销毁
  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
