import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:get/get.dart';

abstract class GetRefreshListController<T> extends BaseController {
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

        setData(result);

        /// 更新界面
        showSuccessPage();
      } else {
        showEmptyPage();
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
      print("---------> refresh 发生了异常 ${error}");

      /// 如果有数据则提示吐司，如果没有数据则展示错误图
      if (getData().isNotEmpty) {
        /// TODO 提示一个吐司，或者不提示
        ///
      } else {
        showErrorPage(msg: error?.toString());
      }
    });
  }

  /// 加载更多
  Future<void> onLoad() async {
    page += 1;

    print("------> onLoad");
    loadData(page).then((result) {
      if (result.isNotEmpty) {
        /// 更新页码
        page += 1;

        addData(result);

        /// 更新界面
        showSuccessPage();
      }

      /// 加载完成
      refreshController.finishLoad();
    }).onError((error, stack) {
      /// 加载失败要 重置页码
      page -= 1;
    });
  }

  /// 加载数据的方法，子类去实现
  /// TODO 返回的数据应该是一个范型，因为他可能是一个对象
  /// TODO 需要添加一个isRefresh,子类刷新和加载可能不一样要区分
  Future<List<T>> loadData(int page);

  /// 添加数据
  void addData(List<T>? data) {
    if (data != null && data.isNotEmpty) {
      var result = getData();
      if (result is List) {
        getData().addAll(data);
      }
    }
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
