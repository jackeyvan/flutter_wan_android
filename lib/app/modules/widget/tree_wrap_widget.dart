import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';

/// 自定义体系和导航的Item组件
class TreeWrap extends StatelessWidget {
  final String? title;

  final List<TreeModel>? items;
  final Function(TreeModel item, int index)? onItemTrap;

  const TreeWrap(
      {super.key, required this.title, required this.items, this.onItemTrap});

  @override
  Widget build(BuildContext context) {
    var data = items;
    if (data != null && data.isNotEmpty && title != null) {
      return Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Wrap(
              spacing: 6,
              alignment: WrapAlignment.start,
              children: buildItems(data),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  buildItems(List<TreeModel> data) {
    return data
        .map(
          (e) => OutlinedButton(
            style: OutlinedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 13)),
            onPressed: () {
              onItemTrap?.call(e, data.indexOf(e));
            },
            child: Text(e.name ?? ""),
          ),
        )
        .toList();
  }
}
