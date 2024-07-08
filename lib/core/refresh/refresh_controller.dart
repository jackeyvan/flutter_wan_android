import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../widgets/widget.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================

abstract class GetRefreshController<T> extends GetxController
    with StateMixin<List<T>> {
  EasyRefreshController refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  /// 分页的页数
  int _page = 0;
  int pageSize = 20;

  /// 子类更改初始的page，默认为0
  int initPage() => 0;

  @override
  void onReady() {
    onRefresh();
    super.onReady();
  }

  /// 刷新数据
  Future<void> onRefresh() async {
    _page = initPage();
    _loadData(true);
  }

  /// 加载更多
  Future<void> onLoad() async {
    _loadData(false);
  }

  /// 数据加载
  void _loadData(bool isRefresh) async {
    loadData(_page).then((data) {
      var noMore = data.length < pageSize;

      /// 如果是刷新就清除数据，并重置状态
      if (isRefresh) {
        /// 设置数据
        setData(data);

        if (data.isEmpty) {
          /// 如果空数据，展示空试图
          change(null, status: RxStatus.empty());
        } else {
          /// 更新界面
          change(data, status: RxStatus.success());
        }

        /// 刷新完成，这里要注意一定是先展示成功的页面，加载EasyRefresh控件
        /// 再调用RefreshController的方法才有用，不然会报错。
        refreshController.finishRefresh();

        /// 刷新的时候，没有更多数据需要去掉上拉加载，没有有更多数据则要重置加载状态
        // if (noMore) {
        //   refreshController.finishLoad();
        // }
      } else {
        if (data.isNotEmpty) {
          addData(data);
        }

        /// 更新界面
        change(data, status: RxStatus.success());

        /// 加载完成
        refreshController.finishLoad();
      }

      /// 更新视图
      update();

      /// 更新页码
      if (data.isNotEmpty) {
        _page += 1;
      }
    }).catchError((e) {
      if (isRefresh) {
        /// 如果没有数据就展示错误视图，如有有数据就提示吐司
        if (getData().isNotEmpty) {
          // Toast.show(e.toString());
        } else {
          // showErrorPage(msg: e.toString());
          change(null, status: RxStatus.error(e.toString()));
        }

        /// 结束刷新状态
        refreshController.finishRefresh();
      } else {
        // Toast.show(e.toString());

        /// 结束加载状态
        refreshController.finishLoad();
      }
    });
  }

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

  /// 最终加载数据的方法
  Future<List<T>> loadData(int page);

  /// 销毁时刷新控件一起销毁
  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
