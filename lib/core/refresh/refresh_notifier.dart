import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:get/state_manager.dart';

mixin RefreshMixin<T> on ListNotifierMixin {
  T? _value;

  Status? _status;

  Status get status {
    notifyChildrens();
    return _status ??= _status = Status.loading();
  }

  @protected
  T? get value {
    notifyChildrens();
    return _value;
  }

  @protected
  set value(T? newData) {
    if (_value == newData) return;
    _value = newData;
    refresh();
  }

  @protected
  void change({T? data, Status? status}) {
    var _canUpdate = false;
    if (status != null) {
      _status = status;
      _canUpdate = true;
    }
    if (data != _value) {
      _value = data;
      _canUpdate = true;
    }
    if (_canUpdate) {
      refresh();
    }
  }

  @protected
  void showLoadingPage() {
    _status = Status.loading();
    refresh();
  }

  @protected
  void showErrorPage({String? msg}) {
    _status = Status.error(msg);
    refresh();
  }

  @protected
  void showEmptyPage() {
    _status = Status.empty();
    refresh();
  }

  @protected
  void showSuccessPage({T? data}) {
    if (data != null) {
      _value = data;
    }
    _status = Status.success();
    refresh();
  }

  void append(Future<T> Function() Function() body, {String? errorMessage}) {
    final compute = body();
    compute().then((newValue) {
      change(data: newValue, status: Status.success());
    }, onError: (err) {
      change(status: Status.error(errorMessage ?? err.toString()));
    });
  }
}

extension StateExt<T> on RefreshMixin<T> {
  Widget obx(
    NotifierBuilder<T?> widget, {
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
  }) {
    return SimpleBuilder(builder: (_) {
      if (status.isLoading) {
        return onLoading ?? const Center(child: CircularProgressIndicator());
      } else if (status.isError) {
        return onError != null
            ? onError(status.errorMessage)
            : Center(child: Text('A error occurred: ${status.errorMessage}'));
      } else if (status.isEmpty) {
        return onEmpty ??
            const SizedBox.shrink(); // Also can be widget(null); but is risky
      }
      return widget(value);
    });
  }
}

class Status {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isEmpty;
  final String? errorMessage;

  Status._({
    this.isEmpty = false,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory Status.loading() {
    return Status._(isLoading: true);
  }

  factory Status.success() {
    return Status._(isSuccess: true);
  }

  factory Status.error([String? message]) {
    return Status._(isError: true, errorMessage: message);
  }

  factory Status.empty() {
    return Status._(isEmpty: true);
  }
}

typedef NotifierBuilder<T> = Widget Function(T data);
